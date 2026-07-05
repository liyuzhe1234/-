# AI 漫画、照片、图画、视频创作知识库

这是一份面向 **AI 生成漫画、照片、图画、视频、短剧、动画短片** 的创作知识库。它不是传统教材，而是把摄影、漫画、绘画、电影、动画、短剧和后期制作知识，转译成 AI 可以使用的变量：prompt、参考图、控制图、ComfyUI workflow、角色一致性、分镜规划、视频镜头、后期检查和交付规格。

> 恢复说明：此前生成的同名文件在当前磁盘中没有找到。这是重建版，保留并整理了核心体系，方便继续扩展。

## 0. 使用方法

### AI 创作五层输入

- **Text Prompt / 文字提示词**：主体、动作、场景、风格、镜头、光线、颜色、质量要求。
- **Reference Image / 参考图**：锁定角色、服装、风格、构图、色彩或场景。
- **Control Signal / 控制信号**：姿势骨架、深度图、线稿、边缘图、分割图、首帧。
- **Model and Workflow / 模型与工作流**：checkpoint、LoRA、ControlNet、IP-Adapter、采样器、步数、CFG、放大、局部重绘。
- **Post-production / 后期**：修手、修脸、调色、排版、字幕、剪辑、声音、导出规格。

### 通用 AI 视觉公式

```text
媒介/作品类型 + 主体 + 动作/情绪 + 场景 + 构图 + 镜头/角度 + 光线 + 色彩 + 风格 + 材质/细节 + 质量控制
```

示例：

```text
cinematic portrait photo, young comic artist leaning over a drawing desk, quiet focused expression, cozy attic studio, foreground sketchbook framing, eye-level 35mm lens, warm window light, muted Morandi palette, realistic photography, subtle film grain, sharp focus on eyes
```

## 1. AI 创作基础术语

- **Prompt / 提示词**：给 AI 的创作指令。
- **Negative Prompt / 负面提示词**：告诉 AI 避免什么，如 bad hands、watermark、blurry。
- **Checkpoint / 大模型**：图像生成主模型，如 SD1.5、SDXL、Juggernaut XL、FLUX。
- **LoRA**：小型风格、角色、服装或概念插件。
- **VAE**：图像解码器，影响颜色和细节。
- **Sampler / 采样器**：控制生成路径，如 Euler、DPM++ 2M。
- **Steps / 步数**：生成迭代次数。
- **CFG Scale / 提示词服从度**：越高越听 prompt，但太高会僵硬或出噪。
- **Seed / 随机种子**：固定后便于复现。
- **Denoise Strength / 重绘强度**：图生图或局部重绘时控制改动幅度。
- **ControlNet**：用姿势、线稿、深度、边缘控制画面结构。
- **IP-Adapter**：用参考图控制角色、风格或构图相似度。
- **Inpainting / 局部重绘**：修脸、手、道具、局部画面。
- **Outpainting / 扩图**：向画面外扩展。
- **Upscale / 放大**：提高分辨率。

## 2. 漫画核心术语

- **Panel / 漫画格**：漫画页面中的单个画面。
- **Gutter / 格间距**：格子之间的空白，读者会在其中脑补动作。
- **Closure / 闭合**：读者根据前后画格推断中间发生的事。
- **Page Layout / 页面布局**：一页漫画中格子的排列。
- **Splash Page / 整页大图**：用整页表现强视觉瞬间。
- **Double-page Spread / 跨页**：左右两页组成一张大画面。
- **Inset Panel / 嵌入小格**：用于特写眼神、手、手机、钥匙等细节。
- **Bleed / 出血**：画面延伸到页面边缘。
- **Breaking the Panel / 破格**：角色或物体冲出格框。
- **Speech Bubble / 对话气泡**：角色说话。
- **Thought Bubble / 思考气泡**：角色内心。
- **Caption / 旁白框**：时间、地点、内心独白或叙述。
- **SFX / 拟声字**：BANG、WHOOSH、咔、轰等视觉化声音。

## 3. AI 漫画为什么难

AI 漫画难点不是单张图是否漂亮，而是连续叙事。

- **角色一致性**：脸、发型、服装、身高、配饰不能漂移。
- **场景一致性**：房间布局、门窗、光源、道具位置要连续。
- **动作连续性**：上一格伸手，下一格要能接上。
- **阅读顺序**：读者要知道先看哪格。
- **对白可读性**：AI 直接生成文字容易乱码，建议后期排字。
- **风格稳定性**：同一页不要一格像日漫，一格像 3D，一格像照片。

### AI 漫画稳定流程

1. 写故事节拍。
2. 做角色 bible。
3. 做场景 bible。
4. 做缩略分镜。
5. 逐格生成。
6. 用局部重绘修脸、手、服装。
7. 统一调色。
8. 后期添加气泡、对白、拟声字。

## 4. 漫画制作流程

- **Premise / 故事前提**：一句话说明故事核心。
- **Logline / 一句话梗概**：当某人遇到某事，他必须做某事，否则会失去某物。
- **Synopsis / 剧情概要**：几百字概括章节或全篇。
- **Beat Sheet / 节拍表**：拆成关键剧情节点。
- **Script / 漫画脚本**：页码、格数、每格画面、对白、旁白、拟声字。
- **Thumbnail / 缩略分镜**：小草图，先解决阅读流。
- **Rough Layout / 粗分镜**：确定人物位置、镜头、气泡。
- **Line Art / 线稿**：干净轮廓。
- **Coloring / 上色**：黑白、彩漫、条漫或封面。
- **Lettering / 嵌字**：对白、旁白、拟声字排版。

## 5. 漫画页面节奏

- **Page Opener / 页首格**：交代地点、时间、情绪。
- **Page Closer / 页尾格**：留下悬念、笑点或情绪落点。
- **Big Panel / 大格**：重要瞬间、慢节奏、强情绪。
- **Small Panel / 小格**：动作拆解、节奏加快。
- **Silent Panel / 无声格**：让情绪停留。
- **Cliffhanger Panel / 悬念格**：页尾或集尾吸引继续阅读。
- **Decompression / 解压叙事**：用多格表现一个短瞬间。
- **Compression / 压缩叙事**：用一格跳过长时间。
- **Eye Flow / 视线流**：人物视线、气泡位置、引导线控制阅读顺序。

## 6. 漫画格间转场

- **Moment-to-Moment / 瞬间到瞬间**：细微变化，如眼泪滑落。
- **Action-to-Action / 动作到动作**：拔剑、挥剑、命中。
- **Subject-to-Subject / 主体到主体**：A 说话，B 反应。
- **Scene-to-Scene / 场景到场景**：跨越时间或地点。
- **Aspect-to-Aspect / 面向到面向**：雨滴、路灯、空巷，营造氛围。
- **Non-sequitur / 非逻辑转场**：梦境、心理崩溃、实验漫画。

## 7. 漫画画风大全

### 黑白日漫风

- **特征**：黑白线稿、网点、速度线、排线、强明暗。
- **Prompt**：black and white manga style, clean ink line art, screentone shading, dynamic speed lines, no color, no text。

### 彩色日漫风

- **特征**：日漫线条 + 彩色上色。
- **Prompt**：color manga illustration, clean line art, soft cel shading, expressive anime eyes。

### 动画截图风

- **特征**：像动画中的一帧，线条干净，阴影简化。
- **Prompt**：anime screenshot style, clean cel shading, cinematic anime background, 16:9 frame。

### 软上色条漫风

- **特征**：线条干净、皮肤和头发柔和渐变、光影精致。
- **Prompt**：Korean webtoon art style, polished characters, soft shading, glossy hair, full color vertical comic。

### 国漫彩绘风

- **特征**：彩色、人物精致、服装华丽、光效明显。
- **Prompt**：Chinese manhua art style, elegant line art, colorful rendering, flowing hanfu, xianxia fantasy atmosphere。

### 欧美超级英雄漫画风

- **特征**：肌肉结构强、粗线条、高对比、动态夸张。
- **Prompt**：American superhero comic style, bold ink outlines, muscular anatomy, dramatic foreshortening, halftone shading。

### 法比清线风

- **特征**：线条均匀清晰，色彩平涂，背景干净。
- **Prompt**：ligne claire comic style, clear outlines, flat colors, clean European comic background。

### 图像小说写实风

- **特征**：比例写实、表情克制、明暗成熟，电影感强。
- **Prompt**：realistic graphic novel style, mature visual storytelling, muted palette, cinematic panel composition。

### 恐怖漫画风

- **特征**：阴影重、表情扭曲、留白不安。
- **Prompt**：horror manga style, unsettling ink shadows, distorted expression, eerie silence, detailed black and white texture。

### Q 版 / Chibi

- **特征**：头大身小，表情夸张，可爱喜剧。
- **Prompt**：chibi comic style, super deformed cute character, oversized head, tiny body, playful expression。

### 水墨漫画风

- **特征**：水墨笔触、留白、浓淡墨色、东方意境。
- **Prompt**：Chinese ink wash comic style, expressive brush strokes, elegant negative space, xianxia atmosphere。

### 半写实漫画风

- **特征**：脸和身体更接近真实，但仍保留漫画美化。
- **Prompt**：semi-realistic comic art style, stylized realistic face, detailed costume, cinematic lighting。

## 8. 漫画画风描述公式

```text
漫画画风 + 线条 + 阴影方式 + 上色方式 + 人物比例 + 背景复杂度 + 情绪气质
```

示例：

```text
Korean webtoon art style, clean thin line art, soft gradient shading, full color rendering, elegant long-legged characters, detailed modern interior background, romantic mood
```

## 9. 人物角色类型

### 故事功能

- **Protagonist / 主角**：故事跟随的人物。
- **Antagonist / 对抗者**：阻碍主角的人或力量。
- **Deuteragonist / 第二主角**：仅次于主角的重要角色。
- **Sidekick / 搭档**：辅助、吐槽、情绪支持。
- **Mentor / 导师**：传授知识或价值观。
- **Rival / 竞争对手**：推动主角成长。
- **Love Interest / 爱情对象**：情感线对象。
- **Trickster / 诡计者**：制造混乱、幽默、反转。
- **Antihero / 反英雄**：道德暧昧但承担主角功能。
- **Comic Relief / 喜剧担当**：缓解紧张。

### 性格原型

- **Hero / 英雄型**：勇敢、承担责任。
- **Rebel / 反叛者**：挑战规则。
- **Explorer / 探索者**：追求自由和未知。
- **Sage / 智者**：理性、知识、观察。
- **Creator / 创造者**：想象力、审美、作品。
- **Caregiver / 照顾者**：温柔、保护、牺牲。
- **Ruler / 统治者**：秩序、权力、控制。
- **Magician / 魔法师**：改变现实，洞察规律。
- **Lover / 爱人型**：关系、亲密、美。
- **Jester / 小丑型**：幽默、享乐、反沉重。

## 10. 人物视觉设定

- **年龄**：儿童、青少年、青年、中年、老年。
- **身体轮廓**：圆形亲切，方形稳定，三角危险，细长优雅，魁梧有力量。
- **气质**：优雅、粗粝、可爱、酷、神秘、混乱、寡言、活力。
- **职业身份**：侦探、骑士、法师、盗贼、科学家、工程师、飞行员、记者、僧侣、刺客、偶像、商人、治疗者、女巫、武士、牛仔、黑客。

### 人物 prompt 模板

```text
角色功能 + 年龄阶段 + 职业身份 + 性格气质 + 服装 + 姿势 + 表情 + 风格
```

## 11. 服装、造型与时尚

- **Casual / 日常休闲**：生活流、校园。
- **Streetwear / 街头潮流**：hoodie、cargo pants、sneakers。
- **Techwear / 机能风**：黑色、多口袋、防水面料、未来都市。
- **Formal Wear / 正装**：西装、衬衫、领带、权力感。
- **Uniform / 制服**：学校、军队、警察、护士。
- **Tactical Gear / 战术装备**：防弹背心、护膝、枪套。
- **Armor / 盔甲**：皮甲、锁子甲、板甲、机甲装甲。
- **Hanfu / 汉服**：交领、宽袖、襦裙、披帛。
- **Cyberpunk Outfit / 赛博朋克服装**：皮革、霓虹线条、义体接口。
- **Post-apocalyptic Outfit / 废土服装**：破损布料、拼接护甲、防尘镜。

## 12. 姿势、动作与肢体语言

- **Power Pose / 权力姿势**：腿分开、肩打开、抬头。
- **Defensive Pose / 防御姿势**：身体后退、手臂护住胸口。
- **Arms Crossed / 抱臂**：防备、冷淡、权威。
- **Reaching Out / 伸手**：渴望、求助、连接。
- **Looking Over Shoulder / 回眸**：神秘、警觉、时尚。
- **Kneeling / 跪下**：臣服、崩溃、仪式。
- **Fighting Stance / 战斗架势**：动作、冲突。
- **Casting Spell / 施法**：奇幻、魔法光效、符文。

## 13. 表情、情绪与微表情

- **Bittersweet Smile / 苦甜微笑**：笑中有悲。
- **Suppressed Anger / 压抑愤怒**：表面平静，手握紧。
- **Nervous Smile / 紧张笑**：不自然，眼神躲避。
- **Relieved Tears / 如释重负的泪**：哭但放松。
- **Stunned Silence / 震惊沉默**：表情冻结。
- **Guilty Look / 愧疚**：低头、避开视线。
- **Determined Expression / 坚定**：眉眼集中、嘴唇紧闭。
- **Melancholic Gaze / 忧郁凝视**：眼神远、低饱和氛围。

## 14. 摄影基础

### 曝光三角

- **Aperture / 光圈**：控制进光量和景深。f/1.8 背景虚化强，f/8 更清楚。
- **Shutter Speed / 快门速度**：高速冻结动作，低速产生运动模糊。
- **ISO / 感光度**：低 ISO 干净，高 ISO 暗光但噪点多。

### 白平衡

- **Warm White Balance / 暖白平衡**：夕阳、室内、亲密。
- **Cool White Balance / 冷白平衡**：夜晚、科技、孤独。

### 对焦

- **Sharp focus on eyes**：人像常用。
- **Shallow depth of field**：背景虚化。
- **Deep focus**：前中后景都清楚。

## 15. 摄影类型

- **Portrait Photography / 人像摄影**：脸、眼神、肤色、情绪。
- **Environmental Portrait / 环境人像**：人物与空间关系。
- **Fashion Photography / 时尚摄影**：服装、姿态、妆发、气场。
- **Street Photography / 街头摄影**：真实瞬间、城市、人群。
- **Documentary Photography / 纪实摄影**：社会现场、真实事件。
- **Landscape Photography / 风光摄影**：自然景观、天气、空间。
- **Architectural Photography / 建筑摄影**：线条、结构、材料。
- **Product Photography / 产品摄影**：外形、材质、高光、卖点。
- **Food Photography / 美食摄影**：食欲、质感、热气、摆盘。
- **Macro Photography / 微距摄影**：极近距离细节。
- **Night Photography / 夜景摄影**：城市灯光、霓虹、长曝光。
- **Astrophotography / 星空摄影**：银河、长曝光、夜空。

## 16. 拍照手法

- **Candid Shot / 抓拍**：自然瞬间。
- **Posed Shot / 摆拍**：精致、可控。
- **Decisive Moment / 决定性瞬间**：动作、构图、情绪刚好达到最有意义的一刻。
- **Long Exposure / 长曝光**：车灯轨迹、流水丝滑。
- **Fast Shutter / 高速快门**：冻结水花、运动、飞鸟。
- **Panning / 追随拍摄**：主体清楚，背景拖影。
- **Silhouette / 剪影**：保留轮廓。
- **Backlit Photography / 逆光**：轮廓光、梦幻。
- **Double Exposure / 双重曝光**：梦境、记忆、隐喻。
- **Tilt-shift / 移轴**：微缩模型感或建筑透视控制。

## 17. 拍照角度与镜头

- **Eye-level / 平视**：自然、平等。
- **Low Angle / 仰拍**：强大、英雄、威胁。
- **High Angle / 俯拍**：脆弱、孤独、被观察。
- **Bird's-eye View / 鸟瞰**：宏观、图案化。
- **Top-down / 垂直俯拍**：食物、桌面、地图。
- **Worm's-eye View / 虫视角**：夸张、压迫、奇观。
- **Dutch Angle / 荷兰角**：不安、混乱、心理失衡。
- **Over-the-shoulder / 过肩**：对话、对峙。
- **POV / 主观视角**：沉浸、恐怖、冒险。
- **Three-quarter View / 三分之四视角**：角色设计常用。

## 18. 焦段与照片质感

- **24mm wide-angle lens**：环境、建筑、临场感。
- **35mm lens**：街拍、环境人像、自然叙事。
- **50mm lens**：标准视角，日常、人像、静物。
- **85mm portrait lens**：人像、虚化、脸部变形少。
- **135mm telephoto lens**：压缩背景，梦幻人像。
- **Macro lens**：极近细节。
- **Fisheye lens**：夸张畸变。
- **Anamorphic lens**：宽银幕、横向光晕、电影感。
- **Film grain**：胶片颗粒。
- **Analog photography**：胶片质感、自然色彩。
- **Polaroid photo**：白边、复古生活感。

## 19. 光线系统

- **Key Light / 主光**：主体主要光源。
- **Fill Light / 补光**：降低阴影。
- **Back Light / 背光**：分离主体和背景。
- **Rim Light / 轮廓光**：勾边。
- **Soft Light / 软光**：阴影柔和，适合人像。
- **Hard Light / 硬光**：阴影清晰，戏剧性强。
- **Rembrandt Lighting / 伦勃朗光**：脸暗侧有三角亮区。
- **Butterfly Lighting / 蝴蝶光**：美妆、明星肖像。
- **Split Lighting / 分割光**：脸一半亮一半暗。
- **Golden Hour / 黄金时刻**：暖光、长阴影。
- **Blue Hour / 蓝调时刻**：冷蓝环境光。
- **Volumetric Light / 体积光**：雾气中可见光束。

## 20. 颜色类型与色彩风格

- **Monochromatic / 单色**：统一、安静、设计感。
- **Black and White / 黑白**：经典、纪实、戏剧化。
- **High Saturation / 高饱和**：活力、广告、年轻。
- **Low Saturation / 低饱和**：高级、电影、忧郁。
- **Pastel Palette / 粉彩**：柔和、治愈、甜美。
- **Neon Palette / 霓虹**：赛博朋克、夜生活。
- **Earth Tones / 大地色**：自然、复古、温暖。
- **Jewel Tones / 宝石色**：华丽、神秘、贵族。
- **Morandi Palette / 莫兰迪色**：低饱和灰调，高级安静。
- **Filmic Color / 胶片色**：柔和高光、自然肤色。
- **Teal and Orange / 蓝橙色**：商业电影感。
- **Complementary Colors / 互补色**：强冲突。
- **Analogous Colors / 邻近色**：和谐统一。

## 21. 绘画与插画风格

- **Realism / 写实**：真实比例、真实光影。
- **Hyperrealism / 超写实**：毛孔、反射、材质极细。
- **Semi-realistic / 半写实**：结构真实但美化。
- **Concept Art / 概念艺术**：服务电影、游戏、动画前期设计。
- **Character Design / 角色设计**：外形、服装、性格、辨识度。
- **Children's Book Illustration / 儿童绘本**：温柔、清晰、友好。
- **Watercolor / 水彩**：透明、晕染、纸纹。
- **Gouache / 水粉**：不透明、复古插画感。
- **Oil Painting / 油画**：厚重、层次丰富。
- **Ink Wash / 水墨**：留白、墨色层次。
- **Ukiyo-e / 浮世绘**：平面色块、日本版画感。
- **Cel Shading / 赛璐璐**：硬边阴影、动画感。
- **Pixel Art / 像素艺术**：低分辨率、有限色板。
- **Low Poly / 低多边形**：几何面片。
- **3D Render / 3D 渲染**：材质、灯光、模型感。
- **Claymation / 黏土风**：手工、定格动画感。
- **Paper Cutout / 剪纸风**：纸张层叠、手工阴影。

## 22. 视觉美学流派

- **Cyberpunk / 赛博朋克**：霓虹、雨夜、高科技低生活。
- **Solarpunk / 太阳朋克**：生态科技、绿色城市、明亮未来。
- **Steampunk / 蒸汽朋克**：黄铜、齿轮、维多利亚。
- **Dieselpunk / 柴油朋克**：复古工业、军工、飞行器。
- **Gothic / 哥特**：尖拱、黑色、烛光、阴郁浪漫。
- **Dark Fantasy / 黑暗奇幻**：魔法、腐败王国、怪物。
- **High Fantasy / 高魔奇幻**：龙、王国、史诗冒险。
- **Cozy Fantasy / 舒适奇幻**：魔法小店、森林小屋、低冲突。
- **Noir / 黑色电影**：侦探、硬光、阴影、道德暧昧。
- **Vaporwave / 蒸汽波**：粉紫蓝、复古电脑、雕塑。
- **Synthwave / 合成器浪潮**：80 年代、霓虹网格。
- **Cottagecore / 田园小屋**：乡村、花草、手作。
- **Liminal Space / 阈限空间**：空商场、走廊、泳池，不安孤独。
- **Brutalism / 粗野主义**：混凝土、巨大几何体。
- **Art Deco / 装饰艺术**：金色、几何、奢华。

## 23. 场景、地点与空间

- **Bedroom / 卧室**：私密、脆弱、成长。
- **Kitchen / 厨房**：家庭、温暖、冲突。
- **Library / 图书馆**：知识、秘密、安静。
- **Hospital / 医院**：生死、焦虑、治疗。
- **Office / 办公室**：职场、权力、疲惫。
- **Cafe / 咖啡馆**：相遇、谈话、温暖。
- **Subway / 地铁**：城市、人群、孤独。
- **Alley / 小巷**：危险、秘密、赛博朋克。
- **Rooftop / 屋顶**：告白、战斗、孤独。
- **Forest / 森林**：童话、迷失、危险。
- **Desert / 沙漠**：孤独、试炼、遗迹。
- **Temple / 神殿**：信仰、谜题、神秘。
- **Laboratory / 实验室**：科学、禁忌、创造。
- **Spaceship / 太空船**：科幻、封闭、未知。

## 24. 道具与视觉符号

- **Key / 钥匙**：秘密、机会、真相。
- **Letter / 信**：过去、告白、遗言。
- **Map / 地图**：冒险、寻找、世界观。
- **Clock / 钟表**：时间限制、停滞。
- **Mirror / 镜子**：身份、自我、双重性。
- **Mask / 面具**：隐藏、伪装、仪式。
- **Ring / 戒指**：承诺、权力、诅咒。
- **Photograph / 照片**：记忆、证据、失去。
- **Book / 书**：知识、魔法、秘密。
- **Candle / 蜡烛**：仪式、希望、脆弱生命。
- **Empty Chair / 空椅子**：缺席、死亡、等待。
- **Open Window / 开窗**：自由、希望、逃离。

## 25. 拍摄、剪辑与叙事手法

- **Montage / 蒙太奇**：组合多个镜头产生意义、情绪或时间压缩。
- **Narrative Montage / 叙事蒙太奇**：快速推进剧情。
- **Parallel Montage / 平行蒙太奇**：两个事件交替，暗示同时发生。
- **Contrast Montage / 对比蒙太奇**：相反画面形成讽刺或冲突。
- **Metaphorical Montage / 隐喻蒙太奇**：用象征画面表达内心。
- **Rhythmic Montage / 节奏蒙太奇**：镜头、动作、音乐节拍配合。
- **Long Take / 长镜头**：沉浸、真实、紧张。
- **One-shot / 一镜到底**：看起来没有剪辑。
- **Jump Cut / 跳切**：省略中间过程，制造跳跃。
- **Match Cut / 匹配剪辑**：形状、动作、颜色或构图相似转场。
- **J-cut**：下个镜头声音先出现。
- **L-cut**：上个镜头声音延续到下个画面。
- **Dissolve / 叠化**：回忆、梦境、时间流逝。
- **Whip Pan / 甩镜转场**：快速摇镜切换场景。
- **Eyeline Match / 视线匹配**：先拍角色看，再拍他看到的东西。
- **Reaction Shot / 反应镜头**：显示角色对事件的反应。
- **Insert Shot / 插入镜头**：钥匙、短信、病历、证据等细节。
- **Reveal Shot / 揭示镜头**：镜头移动后露出关键信息。

## 26. 视频与短剧

### 短剧特点

- **Hook First / 开头钩子**：前 3 到 10 秒出现冲突、悬念或异常。
- **Vertical-first / 竖屏优先**：脸、表情、手机、证据要大。
- **High Conflict / 高冲突密度**：人物关系和利益冲突清楚。
- **Reaction Close-up / 反应特写**：短剧爽点和反转最依赖反应镜头。
- **Evidence Insert / 证据插入**：短信、合同、戒指、病历、监控。
- **Doorway Reveal / 门口揭示**：关键人物出现。
- **Cliffhanger Ending / 集尾悬念**：下一集钩子。

### 短剧 prompt 模板

```text
vertical 9:16 short drama scene, [类型], [人物关系], [冲突事件], [场景], [镜头手法], [表情反应], [光线], [结尾钩子]
```

## 27. 动画短片

- **Anticipation / 预备动作**：跳跃前下蹲，挥拳前后拉。
- **Squash and Stretch / 挤压与拉伸**：弹性、重量、冲击。
- **Follow-through / 跟随动作**：主体停下后头发、衣服继续动。
- **Smear Frame / 拖影帧**：快速动作中的变形帧。
- **Motion Arc / 运动弧线**：自然动作沿弧线。
- **Pose-to-Pose / 姿势到姿势**：先设计关键姿势。
- **Limited Animation / 有限动画**：只动嘴、眼、头发或背景。
- **Parallax / 视差运动**：前景中景背景不同速度移动。
- **Morphing / 形变**：物体平滑变成另一个物体。

### 动画短片 prompt 模板

```text
animated short film scene, [动画风格], [角色], [动作], [情绪], [场景], [镜头运动], [动画原则], [色彩], [声音/音乐气质], stable character design
```

## 28. 世界观设定

- **Era / 时代**：古代、中世纪、现代、未来、末日后。
- **Technology Level / 科技水平**：冷兵器、蒸汽、现代、赛博、星际。
- **Magic Level / 魔法水平**：无魔法、低魔法、高魔法、魔法工业化。
- **Society / 社会结构**：王国、帝国、公司、城邦、部落、学院。
- **Class System / 阶层**：贵族、平民、企业等级、魔法等级。
- **Religion / 信仰**：神殿、教团、禁忌、仪式。
- **Conflict / 核心冲突**：阶级、资源、战争、信仰、科技伦理。

## 29. 故事类型与剧情套路

- **Adventure / 冒险**：离开日常，进入未知。
- **Mystery / 悬疑**：谜题、线索、真相。
- **Romance / 爱情**：关系从距离到靠近。
- **Comedy / 喜剧**：误会、反差、节奏。
- **Tragedy / 悲剧**：角色缺陷导致不可逆损失。
- **Thriller / 惊悚**：危险逼近，信息不完整。
- **Horror / 恐怖**：未知、失控、身体或心理威胁。
- **Slice of Life / 日常**：小事件、细腻情绪。
- **Revenge / 复仇**：伤害、追查、代价。
- **Heist / 盗窃计划**：组队、计划、执行、意外。
- **Training Arc / 修行篇**：失败、训练、突破。
- **Big Reveal / 重大揭示**：身份、真相、世界规则改写。

## 30. 声音、音乐与音效

- **Dialogue / 对白**：人物说话。
- **Voice-over / 旁白**：画外叙述。
- **Ambient Sound / 环境声**：雨、风、街道、人群、机器。
- **Foley / 拟音**：脚步、布料、开门、杯子碰撞。
- **Sound Effect / 音效**：爆炸、魔法、电子提示音。
- **Music / 配乐**：情绪和节奏。
- **Silence / 静音**：强调紧张、震惊、孤独。
- **Orchestral / 管弦乐**：史诗、电影。
- **Ambient / 氛围音乐**：空间、冥想、科幻。
- **Lo-fi / 低保真**：学习、日常、怀旧。
- **Jazz / 爵士**：都市、夜晚、酒吧、侦探。

## 31. 字体、排版、封面

- **Serif / 衬线体**：古典、文学、权威。
- **Sans Serif / 无衬线体**：现代、干净、科技。
- **Script / 花体**：浪漫、优雅。
- **Handwritten / 手写体**：亲密、日记、儿童。
- **Blackletter / 哥特字体**：中世纪、黑暗、金属。
- **Condensed / 窄体**：海报、强标题。
- **Key Art / 主视觉**：最能代表作品的图像。
- **Tagline / 宣传语**：一句情绪或卖点。
- **Safe Area / 安全区**：文字不要贴边，避免平台裁切。

## 32. 材质与纹理

- **Metal / 金属**：brushed metal、polished steel、rusty iron。
- **Glass / 玻璃**：translucent glass、frosted glass。
- **Leather / 皮革**：cracked leather、black leather。
- **Fabric / 布料**：cotton、linen、silk、wool、velvet。
- **Wood / 木头**：温暖、纹理、自然。
- **Stone / 石头**：古老、沉重、粗糙。
- **Concrete / 混凝土**：现代、粗野、冷。
- **Ceramic / 陶瓷**：光洁、手作、脆。
- **Paper / 纸**：脆弱、手作、书写。
- **Wet / 潮湿**：雨夜、反射。
- **Weathered / 风化**：古老、时间感。
- **Scratched / 划痕**：使用痕迹。

## 33. AI 质量问题与负面词

### 常见问题

- 坏手、多指、少指、手融合。
- 脸崩、眼睛不对称、嘴歪。
- 多肢体、多头、身体比例错误。
- 背景乱码、文字乱码、水印。
- 风格漂移、角色漂移。
- 透视错误、道具消失。
- 颜色脏、画面拥挤。

### 常用 Negative Prompt

```text
low quality, blurry, bad anatomy, bad hands, extra fingers, missing fingers, extra limbs, deformed, distorted face, asymmetrical eyes, fused fingers, watermark, logo, text, jpeg artifacts, oversharpened, plastic skin
```

## 34. 一致性制作系统

### 角色 Bible

```text
姓名：
年龄：
身份：
脸型：
发型：
眼睛：
身高体型：
常穿服装：
主色：
标志性道具：
性格：
常用表情：
禁止变化：
```

### 场景 Bible

```text
场景名称：
时代：
地点功能：
主要颜色：
光源：
关键道具：
空间布局：
氛围：
出现时间：
```

### 风格 Bible

```text
画风：
线条：
上色：
明度：
色板：
镜头：
光线：
材质：
后期质感：
负面限制：
```

## 35. ComfyUI 工作流思路

- **CheckpointLoaderSimple**：加载模型。
- **CLIPTextEncode**：正负提示词。
- **KSampler**：采样生成。
- **VAEDecode**：解码成图片。
- **SaveImage**：保存图片。
- **LoadImage**：图生图或参考图。
- **ControlNet**：姿势、线稿、深度控制。
- **IP-Adapter**：参考人物或风格。
- **UpscaleModelLoader**：放大模型。
- **Inpainting**：局部修改。

## 36. 文件规格与平台比例

- **1:1**：头像、社媒方图。
- **4:5**：Instagram 竖图、人像海报。
- **3:4**：角色立绘、漫画封面。
- **2:3**：海报、书封。
- **16:9**：横屏视频、电影分镜、YouTube。
- **9:16**：短视频、手机壁纸、竖屏条漫。
- **21:9**：电影宽银幕、史诗场景。
- **PNG**：无损，适合插画和后期。
- **JPG**：照片和社媒。
- **WEBP**：网页。
- **MP4**：视频通用。
- **sRGB**：网页和社媒最常用。
- **CMYK**：印刷常用，通常后期转换。

## 37. 版权与安全

- 避免直接模仿具体在世艺术家的风格做商用。
- 注意真人肖像权。
- 注意品牌 logo、影视动漫角色、字体、音乐和音效授权。
- 检查 checkpoint 和 LoRA 是否允许商用。
- 更安全的写法：使用流派、媒介、时代、构图、光线描述风格。

## 38. 最终综合 Prompt 框架

### 图片

```text
[题材类型], [主体/角色], [动作/姿势], [场景], [服装造型], [道具], [构图], [拍照角度/镜头], [光线], [颜色风格], [艺术/摄影风格], [材质细节], [情绪], [质量要求]
```

### 漫画

```text
[漫画类型], [页面规格], [格数], [阅读方向], [角色 bible], [场景], [每格内容], [对白/无对白], [线条], [上色], [拟声字], [连续性要求]
```

### 视频

```text
[视频类型], [时长], [主体], [动作], [场景], [镜头景别], [摄像机运动], [拍摄手法], [光线], [色彩], [节奏], [声音/音乐], [稳定性要求]
```

## 39. 最终检查清单

### 出图前

- 主体是谁？
- 他在做什么？
- 发生在哪里？
- 观众从什么角度看？
- 光从哪里来？
- 用什么颜色表达情绪？
- 风格是漫画、摄影、插画、3D 还是视频首帧？
- 角色服装和道具是否明确？
- 是否需要参考图或一致性约束？

### 出图后

- 第一眼焦点是否明确？
- 手、脸、眼睛是否正常？
- 人物比例是否合理？
- 道具和服装是否符合设定？
- 背景是否服务故事？
- 色彩是否统一？
- 是否有乱码文字、水印、奇怪 logo？
- 如果是系列图，角色是否仍像同一个人？

### 做漫画页

- 每格是否承担不同信息？
- 是否有建立镜头、动作格、反应格、转折格？
- 读者视线是否顺畅？
- 台词是否过多？
- 页尾是否有悬念或情绪落点？

### 做视频

- 镜头运动是否过于复杂？
- 主体是否稳定？
- 动作是否能在短时长内读懂？
- 是否需要先做首帧？
- 是否需要分段生成再剪辑？
- 声音和字幕是否已经规划？
