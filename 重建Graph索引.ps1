param(
  [string]$VaultRoot = $PSScriptRoot,
  [switch]$DryRun,
  [switch]$SkipGraphConfig,
  [switch]$NoGraphConfigLock
)

$ErrorActionPreference = 'Stop'

$ManagedMarker = '<!-- AUTO-GRAPH-INDEX: managed by rebuild-graph-index -->'
$ExcludedTopFolders = @('.obsidian', '.trash', 'templates', 'Excalidraw')
$IndexSuffix = -join ([char]0x7D22, [char]0x5F15)
$MaxLevel = 5

function Write-Utf8NoBomFile {
  param(
    [string]$Path,
    [string]$Text
  )

  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($Path, $Text, $utf8NoBom)
}

function Set-GraphConfigWritable {
  param([string]$GraphPath)

  if (Test-Path -LiteralPath $GraphPath) {
    $item = Get-Item -LiteralPath $GraphPath
    if ($item.Attributes -band [IO.FileAttributes]::ReadOnly) {
      $item.Attributes = $item.Attributes -bxor [IO.FileAttributes]::ReadOnly
    }
  }
}

function Set-GraphConfigReadOnly {
  param([string]$GraphPath)

  if ($NoGraphConfigLock -or -not (Test-Path -LiteralPath $GraphPath)) {
    return
  }

  $item = Get-Item -LiteralPath $GraphPath
  $item.Attributes = $item.Attributes -bor [IO.FileAttributes]::ReadOnly
}

function Test-IsExcludedPath {
  param([string]$Path)

  foreach ($name in $ExcludedTopFolders) {
    $excluded = Join-Path $VaultRoot $name
    if ($Path -eq $excluded -or $Path.StartsWith($excluded + [IO.Path]::DirectorySeparatorChar)) {
      return $true
    }
  }

  return $false
}

function Get-CleanName {
  param([string]$Name)

  $clean = $Name -replace '^\d+_', ''
  $clean = $clean -replace '^\d+\.\s*', ''
  $clean = $clean.Replace([string][char]0xFF0C, '')
  $clean = $clean.Replace([string][char]0x3001, '')
  $clean = $clean.Replace(',', '')
  $clean = $clean.Trim()

  if ([string]::IsNullOrWhiteSpace($clean)) {
    return $Name
  }

  return $clean
}

function ConvertTo-VaultLinkTarget {
  param([string]$Path)

  $relative = $Path.Substring($VaultRoot.Length + 1).Replace('\', '/')
  return $relative -replace '\.md$', ''
}

function Test-LikelyManagedIndex {
  param(
    [string]$Path,
    [string]$Title
  )

  if (-not (Test-Path -LiteralPath $Path)) {
    return $false
  }

  $text = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
  if ($text -like "*$ManagedMarker*") {
    return $true
  }

  $lines = $text -split "\r?\n"
  if ($lines.Count -eq 0 -or $lines[0].Trim() -ne "# $Title") {
    return $false
  }

  foreach ($line in $lines[1..($lines.Count - 1)]) {
    $trimmed = $line.Trim()
    if ($trimmed -eq '') {
      continue
    }
    if ($trimmed -notmatch '^- \[\[[^\]]+\]\]$') {
      return $false
    }
  }

  return $true
}

function Get-DirectoryDepth {
  param([string]$DirectoryPath)

  $relative = $DirectoryPath.Substring($VaultRoot.Length).TrimStart([IO.Path]::DirectorySeparatorChar)
  if ([string]::IsNullOrWhiteSpace($relative)) {
    return 0
  }

  return $relative.Split([IO.Path]::DirectorySeparatorChar).Count
}

function Get-IndexPath {
  param([string]$DirectoryPath)

  $folderName = Get-CleanName -Name (Split-Path -Leaf $DirectoryPath)
  $managedIndex = Get-ChildItem -LiteralPath $DirectoryPath -Filter '*.md' -File -ErrorAction SilentlyContinue |
    Where-Object {
      $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
      $text -like "*$ManagedMarker*"
    } |
    Sort-Object Name |
    Select-Object -First 1
  if ($managedIndex) {
    return $managedIndex.FullName
  }

  $preferred = Join-Path $DirectoryPath ($folderName + '.md')
  $fallback = Join-Path $DirectoryPath ($folderName + $IndexSuffix + '.md')

  if (Test-Path -LiteralPath $fallback) {
    return $fallback
  }

  if (-not (Test-Path -LiteralPath $preferred)) {
    return $preferred
  }

  if (Test-LikelyManagedIndex -Path $preferred -Title $folderName) {
    return $preferred
  }

  return $fallback
}

function New-IndexContent {
  param([string]$DirectoryPath)

  $title = Get-CleanName -Name (Split-Path -Leaf $DirectoryPath)
  $indexPath = Get-IndexPath -DirectoryPath $DirectoryPath
  $level = Get-LevelTagForFile -FilePath $indexPath
  $lines = New-Object System.Collections.Generic.List[string]

  $lines.Add('---')
  $lines.Add('tags:')
  $lines.Add("  - $level")
  $lines.Add('---')
  $lines.Add('')
  $lines.Add("# $title")
  $lines.Add('')
  $lines.Add($ManagedMarker)
  $lines.Add('')

  $childDirs = Get-ChildItem -LiteralPath $DirectoryPath -Directory |
    Where-Object { -not (Test-IsExcludedPath -Path $_.FullName) } |
    Sort-Object Name

  foreach ($child in $childDirs) {
    $childIndexPath = Get-IndexPath -DirectoryPath $child.FullName
    $childTitle = Get-CleanName -Name $child.Name
    $target = ConvertTo-VaultLinkTarget -Path $childIndexPath
    $lines.Add("- [[$target|$childTitle]]")
  }

  $directFiles = Get-ChildItem -LiteralPath $DirectoryPath -Filter '*.md' -File |
    Where-Object { $_.FullName -ne $indexPath } |
    Sort-Object BaseName

  foreach ($file in $directFiles) {
    $target = ConvertTo-VaultLinkTarget -Path $file.FullName
    $title = [IO.Path]::GetFileNameWithoutExtension($file.Name)
    $lines.Add("- [[$target|$title]]")
  }

  return ($lines -join "`r`n") + "`r`n"
}

function Update-GraphConfig {
  $graphPath = Join-Path $VaultRoot '.obsidian\graph.json'
  if (-not (Test-Path -LiteralPath $graphPath)) {
    return
  }

  Set-GraphConfigWritable -GraphPath $graphPath

  $graphText = Get-Content -LiteralPath $graphPath -Raw -Encoding UTF8
  if ([string]::IsNullOrWhiteSpace($graphText)) {
    $graph = [pscustomobject]@{}
  } else {
    $graph = $graphText | ConvertFrom-Json
  }

  $graph.showTags = $false
  $graph.hideUnresolved = $true
  $graph.showAttachments = $false
  $graph.showArrow = $false
  $graph.'collapse-color-groups' = $false
  $graph.colorGroups = @(
    [pscustomobject]@{
      query = 'tag:#level/1'
      color = [pscustomobject]@{ a = 1; rgb = 3447003 }
    },
    [pscustomobject]@{
      query = 'tag:#level/2'
      color = [pscustomobject]@{ a = 1; rgb = 3066993 }
    },
    [pscustomobject]@{
      query = 'tag:#level/3'
      color = [pscustomobject]@{ a = 1; rgb = 16753920 }
    },
    [pscustomobject]@{
      query = 'tag:#level/4'
      color = [pscustomobject]@{ a = 1; rgb = 10181046 }
    },
    [pscustomobject]@{
      query = 'tag:#level/5'
      color = [pscustomobject]@{ a = 1; rgb = 15158332 }
    }
  )

  if (-not $DryRun) {
    $json = $graph | ConvertTo-Json -Depth 20
    Write-Utf8NoBomFile -Path $graphPath -Text ($json + "`r`n")

    $check = Get-Content -LiteralPath $graphPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if (-not $check.colorGroups -or $check.colorGroups.Count -ne 5) {
      throw "Graph config colorGroups validation failed for $graphPath"
    }

    Set-GraphConfigReadOnly -GraphPath $graphPath
  }
}

function Get-LevelTagForFile {
  param([string]$FilePath)

  $directory = Split-Path -Parent $FilePath
  $indexPath = Get-IndexPath -DirectoryPath $directory
  $depth = Get-DirectoryDepth -DirectoryPath $directory

  if ($FilePath -eq $indexPath) {
    $levelNumber = [Math]::Max(1, $depth)
  } else {
    $levelNumber = [Math]::Max(1, $depth + 1)
  }

  $levelNumber = [Math]::Min($MaxLevel, $levelNumber)
  return "level/$levelNumber"
}

function Set-OnlyLevelTag {
  param(
    [string]$FilePath,
    [string]$LevelTag
  )

  $text = Get-Content -LiteralPath $FilePath -Raw -Encoding UTF8
  $newline = "`r`n"
  if ($text -notmatch "`r`n") {
    $newline = "`n"
  }
  $tagBlock = "tags:$newline  - $LevelTag"

  $normalized = $text -replace "`r`n", "`n"
  $normalized = $normalized.TrimStart([char]0xFEFF)
  $lines = @($normalized -split "`n")
  if ($lines.Count -gt 0 -and $lines[0] -eq '---') {
    $closingIndex = -1
    for ($i = 1; $i -lt $lines.Count; $i++) {
      if ($lines[$i] -match '^-{3,}\s*$') {
        $closingIndex = $i
        break
      }
    }

    if ($closingIndex -gt 0) {
      $frontmatterLines = @($lines[1..($closingIndex - 1)])
      $restLines = @()
      if ($closingIndex + 1 -lt $lines.Count) {
        $restLines = @($lines[($closingIndex + 1)..($lines.Count - 1)])
      }

      while ($restLines.Count -gt 0) {
        $startIndex = 0
        while ($startIndex -lt $restLines.Count -and $restLines[$startIndex].Trim() -eq '') {
          $startIndex++
        }
        if ($startIndex -ge $restLines.Count -or $restLines[$startIndex] -ne '---') {
          break
        }

        $duplicateCloseIndex = -1
        for ($i = $startIndex + 1; $i -lt $restLines.Count; $i++) {
          if ($restLines[$i] -match '^-{3,}\s*$') {
            $duplicateCloseIndex = $i
            break
          }
        }
        if ($duplicateCloseIndex -lt 0) {
          break
        }

        $duplicateBody = @($restLines[($startIndex + 1)..($duplicateCloseIndex - 1)])
        $isDuplicateLevelBlock = ($duplicateBody -match '^tags:\s*$') -and ($duplicateBody -match 'level/[1-5]')
        if (-not $isDuplicateLevelBlock) {
          break
        }

        if ($duplicateCloseIndex + 1 -lt $restLines.Count) {
          $restLines = @($restLines[($duplicateCloseIndex + 1)..($restLines.Count - 1)])
        } else {
          $restLines = @()
        }
      }

      $newFrontmatter = New-Object System.Collections.Generic.List[string]
      $skipTags = $false
      foreach ($line in $frontmatterLines) {
        if ($line -match '^tags:\s*$') {
          $skipTags = $true
          continue
        }
        if ($skipTags -and $line -match '^\s*-\s+') {
          continue
        }
        $skipTags = $false
        if ($line.Trim() -ne '') {
          $newFrontmatter.Add($line)
        }
      }

      $newFrontmatter.Add('tags:')
      $newFrontmatter.Add("  - $LevelTag")
      $newLines = @('---') + @($newFrontmatter) + @('---') + $restLines
      $newText = ($newLines -join $newline)
    } else {
      $newText = '---' + $newline + $tagBlock + $newline + '---' + $newline + $newline + $text.TrimStart("`r", "`n")
    }
  } else {
    $newText = '---' + $newline + $tagBlock + $newline + '---' + $newline + $newline + $text.TrimStart("`r", "`n")
  }

  if ($newText -ne $text) {
    if (-not $DryRun) {
      $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
      [System.IO.File]::WriteAllText($FilePath, $newText, $utf8NoBom)
    }
    return $true
  }

  return $false
}

function Update-LevelTags {
  $changed = 0
  $counts = @{
    'level/1' = 0
    'level/2' = 0
    'level/3' = 0
    'level/4' = 0
    'level/5' = 0
  }

  Get-ChildItem -LiteralPath $VaultRoot -Recurse -Filter '*.md' -File |
    Where-Object { -not (Test-IsExcludedPath -Path $_.FullName) } |
    ForEach-Object {
      $level = Get-LevelTagForFile -FilePath $_.FullName
      $counts[$level]++
      if (Set-OnlyLevelTag -FilePath $_.FullName -LevelTag $level) {
        $changed++
      }
    }

  return [pscustomobject]@{
    Changed = $changed
    Level1 = $counts['level/1']
    Level2 = $counts['level/2']
    Level3 = $counts['level/3']
    Level4 = $counts['level/4']
    Level5 = $counts['level/5']
  }
}

function Test-IndexLinks {
  param([array]$Directories)

  $violations = New-Object System.Collections.Generic.List[object]

  foreach ($dir in $Directories) {
    $indexPath = Get-IndexPath -DirectoryPath $dir.FullName
    if (-not (Test-Path -LiteralPath $indexPath)) {
      $violations.Add([pscustomobject]@{
        Index = $indexPath.Substring($VaultRoot.Length + 1)
        Link = ''
        Problem = 'missing index'
      })
      continue
    }

    $childIndexPaths = @{}
    Get-ChildItem -LiteralPath $dir.FullName -Directory |
      Where-Object { -not (Test-IsExcludedPath -Path $_.FullName) } |
      ForEach-Object {
        $childIndexPaths[(Get-IndexPath -DirectoryPath $_.FullName)] = $true
      }

    $text = Get-Content -LiteralPath $indexPath -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($text, '\[\[([^\]|#]+)(?:[#|][^\]]*)?\]\]')) {
      $target = $match.Groups[1].Value
      $targetPath = Join-Path $VaultRoot (($target -replace '/', '\') + '.md')

      if (-not (Test-Path -LiteralPath $targetPath)) {
        $violations.Add([pscustomobject]@{
          Index = $indexPath.Substring($VaultRoot.Length + 1)
          Link = $target
          Problem = 'missing'
        })
        continue
      }

      $targetDir = Split-Path -Parent $targetPath
      $sameDir = $targetDir -eq $dir.FullName
      $directChildIndex = $childIndexPaths.ContainsKey($targetPath)

      if (-not ($sameDir -or $directChildIndex)) {
        $violations.Add([pscustomobject]@{
          Index = $indexPath.Substring($VaultRoot.Length + 1)
          Link = $target
          Problem = 'not direct child'
        })
      }
    }
  }

  return $violations
}

$VaultRoot = (Resolve-Path -LiteralPath $VaultRoot).Path

$obsidianProcesses = Get-Process -ErrorAction SilentlyContinue |
  Where-Object { $_.ProcessName -eq 'Obsidian' }

if ($obsidianProcesses -and -not $SkipGraphConfig) {
  Write-Warning 'Obsidian is running. Index files will be updated, but graph.json may be overwritten when Obsidian exits. Close Obsidian and run again if Graph settings revert.'
}

$directories = Get-ChildItem -LiteralPath $VaultRoot -Recurse -Directory |
  Where-Object { -not (Test-IsExcludedPath -Path $_.FullName) } |
  Sort-Object FullName

$created = 0
$updated = 0
$unchanged = 0

foreach ($dir in $directories) {
  $indexPath = Get-IndexPath -DirectoryPath $dir.FullName
  $content = New-IndexContent -DirectoryPath $dir.FullName

  if (-not (Test-Path -LiteralPath $indexPath)) {
    if (-not $DryRun) {
      Set-Content -LiteralPath $indexPath -Value $content -Encoding UTF8 -NoNewline
    }
    $created++
    continue
  }

  $old = Get-Content -LiteralPath $indexPath -Raw -Encoding UTF8
  if ($old -ne $content) {
    if (-not $DryRun) {
      Set-Content -LiteralPath $indexPath -Value $content -Encoding UTF8 -NoNewline
    }
    $updated++
  } else {
    $unchanged++
  }
}

if (-not $SkipGraphConfig) {
  Update-GraphConfig
}

$levelTagResult = Update-LevelTags

$violations = Test-IndexLinks -Directories $directories
if ($violations.Count -gt 0) {
  Write-Host 'Index validation found missing or cross-level links:'
  $violations | Format-Table -AutoSize
  exit 1
}

Write-Host "Index rebuild complete. Created=$created Updated=$updated Unchanged=$unchanged"
Write-Host "Level tags updated. Changed=$($levelTagResult.Changed) Level1=$($levelTagResult.Level1) Level2=$($levelTagResult.Level2) Level3=$($levelTagResult.Level3) Level4=$($levelTagResult.Level4) Level5=$($levelTagResult.Level5)"
Write-Host 'Validation passed: every index note only links to direct children.'
