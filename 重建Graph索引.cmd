@echo off
setlocal
cd /d "%~dp0"
set "VAULT_ROOT=%CD%"
set "GRAPH_LOG=%~dp0graph-index-rebuild.log"

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $log=$env:GRAPH_LOG; Set-Content -LiteralPath $log -Encoding UTF8 -Value ('[{0}] Start rebuild' -f (Get-Date)); try { $obsidian=Get-Process Obsidian -ErrorAction SilentlyContinue; if ($obsidian) { Add-Content -LiteralPath $log -Encoding UTF8 -Value 'Closing Obsidian before rebuild'; foreach ($p in $obsidian) { if ($p.MainWindowHandle -ne 0) { [void]$p.CloseMainWindow() } }; Start-Sleep -Seconds 3; Get-Process Obsidian -ErrorAction SilentlyContinue | Stop-Process -Force }; $root=$env:VAULT_ROOT; Set-Location -LiteralPath $root; $script=Get-ChildItem -LiteralPath $root -Filter '*Graph*.ps1' | Where-Object { $_.Extension -eq '.ps1' } | Select-Object -First 1; if (-not $script) { throw 'rebuild script not found' }; & $script.FullName -VaultRoot $root *>&1 | ForEach-Object { $_; Add-Content -LiteralPath $log -Encoding UTF8 -Value $_ }; Add-Content -LiteralPath $log -Encoding UTF8 -Value 'ExitCode=0'; exit 0 } catch { Write-Error $_; Add-Content -LiteralPath $log -Encoding UTF8 -Value $_; Add-Content -LiteralPath $log -Encoding UTF8 -Value 'ExitCode=1'; exit 1 }"

echo.
pause
