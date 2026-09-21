---
description: 规范索引与技能导航（薄入口，详细内容按需读取）
alwaysApply: true
---

# PROJECT_GUIDE

本文件同时作为 `CLAUDE.md`、`AGENTS.md` 的软链目标，是 Cursor / Claude Code / Codex 的共同启动说明。

只放所有 Agent 默认必读的行为规则和路由；业务细节、完整流程按需读取专题文档。

## 默认行为

- **珍惜人的时间（最高优先级）**：人的等待、重复确认和无效来回都是实际成本。在不降低质量、不绕过安全门禁的前提下，优先并行、一次性汇总；能从现有上下文可靠确定的事项直接推进到可验证结果。
- 并行优先：相互独立的读文件、搜索、命令必须并行执行。
- 顺序场景不并行：任务存在强依赖、会修改同一文件或需要在主线累积上下文时，按顺序执行。
- 明确目标后直接执行到可验证状态；仅在不可逆操作、需求冲突或高风险猜测时暂停确认。
- 改业务代码时，先确认仓库和分支，再动手。本仓是助手仓，默认不要把业务实现写进 `fuyuji_robot`。

## 当前仓库定位

本仓库 `fuyuji_robot` 是浮屿记开发助手基础设施，不是客户端或后端业务仓。

- 业务代码在 4 个独立仓库，保持独立 git / 独立 PR。
- 本地路径见 `doc/project/LocalPaths_LOCAL.md`（gitignore，从模板复制）。
- 仓库地图和联调链路见：`doc/project/FuyujiOverview_DOC.md`。

## 指令优先级

1. 对话里的明确指令
2. 当前文件
3. 当前业务仓自己的 `AGENTS.md` / `CLAUDE.md` / `.cursor/rules`
4. 项目级 skills（本仓 `skills/`）
5. 全局 skills
6. 专题文档

同名 skill 优先使用项目级版本。端内规范优先于本仓的跨仓路由。

## 业务仓怎么找

| 简称 | 仓库目录 | 端内 Agent 入口 |
| --- | --- | --- |
| ios | `DiguProject` | `CLAUDE.md` |
| android | `fuyuji-android-module` | `CLAUDE.md` |
| web | `dailyhole-web` | `CLAUDE.md` |
| backend | `dailyhole` | `CLAUDE.md` + `README.md` |

Cursor 请打开 `fuyuji_robot.code-workspace`（5 个 folder）。绝对路径以 `doc/project/LocalPaths_LOCAL.md` 为准，不要硬编码 `/Users/xxx`。

跨端约定：**iOS 是产品体验和字段含义的 Source of Truth**。Android 是 iOS 复刻；Web 是管理后台，不是 C 端。

## Skill 路由

只在任务明确匹配时读取对应 skill，禁止为了“了解全貌”一次性读取大量 skill。

Skill 目录分层：

- `skills/`：默认激活的项目 skill。Cursor / Claude Code / Codex 分别通过 `.cursor/skills`、`.claude/skills`、`.codex/skills` 软链暴露。
- `skills-on-demand/`：可用但不默认激活的按需 skill。用户明确提到名称或意图时再读取。

- 需求分析：`requirement-analysis`
- 技术方案：`system-design`
- 编码规划：`plan-work`
- 跨端交付（iOS→Android 复刻、后端 API 双端接入）：`cross-platform-delivery`
- 编码实现：`coding-standards`
- 长时复杂目标：`goal-contract` + 宿主原生 Goal（目标不清时先 `/plan`）
- 真实测试：`integration-test`
- 缺陷修复：`fix-bug`
- 代码评审：`code-review`
- 结构重构：`refactor`
- 文档同步：`code-write-doc`
- Git 提交：`git-commit`
- 企微机器人：`wecom-robot`（市场 skill，可选）

运维类 skill 路由详见：`doc/project/SkillRouting_DOC.md`。完整索引：`doc/project/SkillIndex_DOC.md`。

## 常用文档入口

- 仓库地图：`doc/project/FuyujiOverview_DOC.md`
- 本地启动：`doc/project/FuyujiLocalStart_DOC.md`
- Git 地址：`doc/project/RepoAddresses_DOC.md`
- 本地路径模板：`doc/project/LocalPaths_TEMPLATE.md`
- 本机路径：`doc/project/LocalPaths_LOCAL.md`
- Skill 索引：`doc/project/SkillIndex_DOC.md`
- Skill 路由：`doc/project/SkillRouting_DOC.md`
- Skill 说明：`skills/README.md`
