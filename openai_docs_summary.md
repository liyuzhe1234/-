# OpenAI 使用指南主要内容摘要

整理日期：2026-07-05  
说明：本文根据用户提供的 OpenAI 官方网址整理，内容为中文概括，适合作为快速导航和学习索引。实际价格、可用性、服务状态和政策可能变化，使用前应以原页面为准。

## 1. OpenAI 帮助中心总入口

官方地址：<https://help.openai.com/>

OpenAI 帮助中心是面向 ChatGPT、API、账号、登录、账单、隐私、安全、企业管理和故障排查的支持入口。首页按主题分类，包括账号与账单、API、ChatGPT、Codex、ChatGPT Business、ChatGPT Enterprise/Edu、隐私与政策、SSO/SCIM/用户管理等。

适合用途：

- 查找账号登录、订阅、退款、账单和访问问题。
- 查找 ChatGPT 功能说明、移动端/桌面端问题和产品 FAQ。
- 查找 API 常见问题、模型说明和平台入口。
- 访问服务状态页、ChatGPT、API 平台等相关入口。

## 2. ChatGPT 使用指南合集

官方地址：<https://help.openai.com/en/collections/3742473-chatgpt>

这是 ChatGPT 相关帮助文章的集合页，覆盖 ChatGPT 的主要功能、订阅计划、数据控制、文件上传、图像输入、语音、搜索、GPTs、项目、任务、移动端和桌面端应用等。

主要内容：

- ChatGPT 基础说明：什么是 ChatGPT、免费层、Plus、Pro、Go 等计划说明。
- 功能指南：数据分析、深度研究、Canvas、Projects、Temporary Chat、Shared Links、Scheduled Tasks、Study Mode、Search、Voice、Images 等。
- 数据与隐私：数据导出、删除账号、关闭训练、聊天和文件保留、共享链接管理。
- 连接应用：Google Drive、GitHub、Microsoft Teams、SharePoint、Notion、Dropbox、Linear 等应用或同步功能。
- GPTs：创建、编辑、共享、发布、企业访问控制和故障排查。
- 平台客户端：iOS、Android、macOS、Windows 应用的安装、使用、订阅、文件上传和故障排查。

## 3. ChatGPT 提示词/Prompt 使用建议

官方地址：<https://help.openai.com/ja-jp/articles/10032626-prompt-engineering-best-practices-for-chatgpt>

该文章说明如何为 ChatGPT 编写更有效的提示词。页面为机器翻译版本，核心建议同样适用于 ChatGPT 使用场景。

主要内容：

- Prompt 是向大语言模型输入的文本或其他形式的内容，用于开启对话或引导模型输出。
- Prompt engineering 是设计和优化输入提示，从而更有效地引导模型回答的过程。
- 写提示词时应清晰、具体，提供足够上下文，避免含糊表达。
- 提示词通常需要迭代优化：先尝试一个版本，观察输出，再调整措辞、上下文、格式或约束。
- 可以明确要求语气，例如正式、友好、专业、幽默或严肃。
- 页面还链接到提示工程基础指南、推理模型提示指南、ChatGPT 自定义指令和功能说明等延伸资源。

## 4. ChatGPT 更新日志

官方地址：<https://help.openai.com/en/articles/6825453-chatgpt-release-notes>

这是 ChatGPT 的产品更新日志，按日期记录新功能、模型变化、功能扩展、客户端更新和可用性调整。

截至页面当前内容，近期更新示例包括：

- 2026-06-26：个人金融体验扩展到美国 Plus 用户和 Android；ChatGPT dictation 使用新的语音转文本模型；GPT-4.5 在 ChatGPT 中退役，既有对话可继续使用 GPT-5.5。
- 2026-06-25：Codex Remote 正式可用，并新增 DigitalOcean Droplet Workspace 插件。
- 2026-06-24：GPT-5.5 Instant 更新，提升决策、建议、计划、研究和购物等对话质量。

适合用途：

- 追踪 ChatGPT 最近功能变化。
- 确认可用模型、退役模型和客户端功能的变化日期。
- 排查某项功能是否因逐步发布、计划限制或区域限制而暂未可用。

## 5. OpenAI API 开发者文档总入口

官方地址：<https://developers.openai.com/api/docs>

这是 OpenAI API 文档的主要入口，覆盖模型调用、工具使用、多模态、结构化输出、Agents SDK、Realtime、图像、音频、视频、文件检索、安全、生产部署和成本优化等。

主要内容：

- 构建路径：Responses API 用于直接模型请求、文本/图像/工具/多模态工作流；Agents SDK 用于构建可编排工具、handoff、审批、追踪和容器执行的代理系统。
- 模型建议：复杂推理和编码可从 GPT-5.5 开始；低延迟或低成本场景可考虑 GPT-5.4 mini 或 GPT-5.4 nano。
- 入门方向：文本生成、视觉理解、图像生成、音频应用、agentic 应用、推理任务、结构化数据、微调/evals/distillation。
- 生产主题：流式输出、后台模式、Webhooks、WebSocket、提示缓存、速率限制、请求 ID、错误码、安全检查和部署清单。

## 6. API Quickstart 快速开始

官方地址：<https://developers.openai.com/api/docs/quickstart>

Quickstart 说明如何完成第一次 OpenAI API 调用。

主要步骤：

- 创建 API key。
- 安装官方 SDK，例如 JavaScript/TypeScript 的 `openai` npm 包，或 Python 的 `openai` pip 包。
- 使用 Responses API 发送一个基础请求。
- 查看返回的 `output_text`。
- 添加额度或配置账单后继续构建真实应用。

页面提供多语言示例，包括 JavaScript、Python、.NET、Java 和 Go，并建议继续探索 Chat Playground、Agents SDK、模型文档和其他构建工具。

## 7. API Reference 接口参考

官方地址：<https://developers.openai.com/api/reference/overview/>

API Reference 用于查询 OpenAI API 的端点、请求/响应 schema、流式事件、客户端库方法，以及认证、错误、速率限制和 request ID 等通用行为。

主要内容：

- 根据应用选择 API surface：Responses API、Realtime API、Administration API 等。
- 认证方式包括标准 API key、Admin API key，以及通过 workload identity federation 创建的短期访问令牌。
- API key 是敏感凭据，不应暴露在浏览器、客户端应用或公开代码中；推荐从服务器环境变量或密钥管理服务读取。
- HTTP 调用使用 Bearer 认证：`Authorization: Bearer OPENAI_API_KEY_OR_ACCESS_TOKEN`。
- 多组织或项目场景可通过 `OpenAI-Organization` 和 `OpenAI-Project` header 指定上下文。
- 生产前应查看错误码、速率限制和 request ID 日志记录。

## 8. 模型列表与选择说明

官方地址：<https://developers.openai.com/api/docs/models>

模型页说明如何选择 OpenAI API 模型，并列出不同模型的能力、价格、上下文窗口和适用场景。

主要内容：

- GPT-5.6 当前面向部分可信合作伙伴预览，更广泛可用性即将到来。
- 不确定从哪里开始时，文档建议使用 GPT-5.5 作为复杂推理和编码的旗舰模型。
- 若优化延迟和成本，可选择 GPT-5.4 mini 或 GPT-5.4 nano。
- 最新 OpenAI 模型支持文本和图像输入、文本输出、多语言能力和视觉能力。
- 模型可通过 Responses API 和官方 Client SDK 使用。
- 页面还列出模型 ID、推理能力、输入/输出价格、最大输出、上下文窗口、工具支持等信息。

## 9. OpenAI Cookbook 示例代码/实践案例

官方地址：<https://cookbook.openai.com/>

OpenAI Cookbook 是示例代码和实践案例集合，面向开发者展示如何在真实场景中使用 OpenAI 模型和 API。

主要内容：

- 主题包括 Agents、Multimodal、Text、Guardrails、Optimization、gpt-oss 等。
- GPT-5 相关内容包括 GPT-5.2 Prompting Guide、Codex Prompting Guide、GPT-5.1/GPT-5 prompting guide、函数调用与新参数、前端编码等。
- Featured cookbooks 包括图像/视觉提示指南、evals、从原型到生产的系统设计、强化微调模型评分器、多工具 RAG 编排、语音助手等。
- Popular cookbooks 包括自进化 agents、Responses API 的 Web Search、MCP 语音框架、基于 File Search 的 PDF RAG、推理数据校验、函数调用等。

## 10. Codex 官方文档

官方地址：<https://developers.openai.com/codex>

Codex 是 OpenAI 面向软件开发的 coding agent。ChatGPT Plus、Pro、Business、Edu 和 Enterprise 计划包含 Codex。

主要能力：

- 写代码：根据自然语言需求生成代码，并适配现有项目结构和约定。
- 理解代码库：阅读并解释复杂或遗留代码。
- 代码审查：识别潜在 bug、逻辑错误和遗漏边界条件。
- 调试修复：追踪失败、诊断根因并提出有针对性的修复。
- 自动化开发任务：执行重构、测试、迁移、环境配置等重复工程流程。

文档还包含 Codex 快速开始、用例、社区、插件、配置、权限、MCP、AGENTS.md、Hooks、CLI、IDE 扩展、桌面 App、Web、集成和自动化等内容。

## 11. ChatGPT Apps SDK 文档

官方地址：<https://developers.openai.com/apps-sdk>

Apps SDK 是用于构建 ChatGPT 应用的框架。它围绕 MCP server、工具、组件和 ChatGPT 内嵌 UI 运行时来构建可交互应用。

主要内容：

- Get started：当前公开分发仍通过应用提交流程；获批应用会出现在 ChatGPT apps store，并由 OpenAI 创建可用于 Codex 分发的插件。
- Create your app：研究用例、定义工具、搭建 MCP server、构建 ChatGPT UI、处理认证和状态管理。
- Deploy：部署 MCP server、从 ChatGPT 连接、测试集成、提交应用。
- Design for quality：遵循应用提交指南、UX 原则和 UI guidelines，使应用符合质量、安全和政策要求。
- Guides：优化 metadata、安全与隐私、故障排查。

## 12. OpenAI 平台入口

官方地址：<https://platform.openai.com/>

OpenAI Platform 是开发者控制台入口，通常用于管理 API key、项目、账单、用量、Playground、模型调用和开发者资源。该页面需要登录后才能完整使用；未登录或公开抓取时可见内容有限。

适合用途：

- 创建和管理 API key。
- 查看账单、额度、用量和组织/项目设置。
- 使用 Playground 测试模型和提示。
- 管理开发者账号和平台相关配置。

## 13. 价格页

官方地址：<https://openai.com/api/pricing/>

当前访问该链接会跳转到 OpenAI Business pricing 页面，展示 Business 和 Enterprise 计划的价格与功能对比。

主要内容：

- Business：面向成长型团队的安全工作区，包含 ChatGPT 与 Codex、团队上下文、工具连接、集中账单和管理、用量分析、预算与支出控制、SAML SSO/MFA，以及默认不使用业务数据训练。
- Enterprise：面向更大规模组织，采用定制价格，包含更大的上下文窗口、企业级安全控制、SCIM、EKM、用户分析、域名验证、RBAC、自定义数据保留、数据驻留、优先支持、SLA 和批量折扣等。
- 页面还比较了消息、聊天历史、Web/iOS/Android、模型访问、响应速度、上下文窗口、语音、Apps、Memory、Search、Canvas、文件上传、GPTs、数据分析、视觉等功能。

注意：如果你需要 API 按 token 的具体价格，应以模型页或当前 API pricing 页面中实际展示的模型价格为准。

## 14. 服务状态页

官方地址：<https://status.openai.com/>

OpenAI Status 用于查看 API、ChatGPT、Codex、FedRAMP、Ads Platform 等服务的可用性和当前事件。

当前页面要点：

- 页面显示系统状态和近期可用性指标。
- API、ChatGPT、Codex、FedRAMP 等按组件展示。
- 状态页可能显示当前正在调查或恢复中的事件。
- 可订阅更新，也可查看历史事件。
- 可用性指标为跨层级、模型和错误类型的聚合数据，单个客户的体验可能因订阅层级、模型和 API 功能而不同。

## 15. 条款与政策

官方地址：<https://openai.com/policies/>

条款与政策页集中列出 OpenAI 服务相关政策、隐私、数据使用、安全披露和产品规则。

主要内容：

- Terms of Use 与 Privacy Policy。
- Usage policies、服务条款、隐私和数据相关说明。
- Coordinated vulnerability disclosure policy 与 outbound coordinated disclosure policy。
- Your data and model performance：说明 OpenAI 如何使用服务内容改进和训练模型。
- How our models are developed：说明模型开发方式及其在 ChatGPT 等产品中的应用。
- Cookie policy、Health Privacy Notice、Ad policies、Commerce policies 等。

## 建议阅读路径

如果你是普通 ChatGPT 用户：

1. 先看 ChatGPT 使用指南合集。
2. 再看 Prompt 使用建议。
3. 需要排查问题时看帮助中心和服务状态页。
4. 需要了解新功能时看 ChatGPT 更新日志。

如果你是 API 开发者：

1. 先看 API 文档总入口。
2. 跟 Quickstart 完成第一次 API 调用。
3. 再看 API Reference 理解端点、认证、错误和速率限制。
4. 根据模型页选择模型。
5. 用 Cookbook 学习真实代码示例。

如果你要做工程开发或自动化：

1. 先看 Codex 官方文档。
2. 若要扩展 ChatGPT 体验，再看 Apps SDK。
3. 涉及生产部署、成本、权限和合规时，同时查看平台、价格、状态和政策页面。

## 来源链接汇总

- OpenAI Help Center：<https://help.openai.com/>
- ChatGPT 使用指南合集：<https://help.openai.com/en/collections/3742473-chatgpt>
- ChatGPT Prompt 使用建议：<https://help.openai.com/ja-jp/articles/10032626-prompt-engineering-best-practices-for-chatgpt>
- ChatGPT Release Notes：<https://help.openai.com/en/articles/6825453-chatgpt-release-notes>
- OpenAI API Docs：<https://developers.openai.com/api/docs>
- API Quickstart：<https://developers.openai.com/api/docs/quickstart>
- API Reference：<https://developers.openai.com/api/reference/overview/>
- Models：<https://developers.openai.com/api/docs/models>
- OpenAI Cookbook：<https://cookbook.openai.com/>
- Codex：<https://developers.openai.com/codex>
- ChatGPT Apps SDK：<https://developers.openai.com/apps-sdk>
- OpenAI Platform：<https://platform.openai.com/>
- Pricing：<https://openai.com/api/pricing/>
- OpenAI Status：<https://status.openai.com/>
- Terms & Policies：<https://openai.com/policies/>
