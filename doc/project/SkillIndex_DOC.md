# Skill 索引

- 来源：从 `dada-agent` 同步流程 skill，按浮屿记裁剪（2026-09-21）
- 更新时间：2026-09-21

[TOC]

## 1. 使用原则

本文件是完整 skill 路由索引，默认不进入 Agent 启动上下文。

只有在任务需要查找合适 skill、确认同类 skill 边界、或补充低频能力时，再读取本文件。

同名 skill 优先使用项目级版本；项目级没有时，再使用 `~/.agents/skills/` 市场版或全局 skill。

Skill 目录分层：

- `skills/`：默认激活的项目 skill。
- `skills-on-demand/`：可用但不默认激活的按需 skill，用户明确提到名称或意图时再读取。

## 2. 默认激活 Skill

默认激活 skill 放在 `skills/`，同时通过 `.cursor/skills`、`.claude/skills` 和 `.codex/skills` 暴露。

| Skill | 用途 |
|-------|------|
| `work-spec` | 沟通、文档、流程总约定 |
| `coding-standards` | 编码总规范：命名、结构、日志、数据层、异常、性能、并发、安全、测试 |
| `integration-test` | 真实应用端到端测试 |
| `requirement-analysis` | 需求分析：整理原始需求、用户视角场景拆解 |
| `system-design` | 技术方案设计 |
| `plan-work` | 编码实施规划 |
| `cross-platform-delivery` | 跨端交付：iOS→Android 复刻、backend→双端 API 接入、联调 |
| `fix-bug` | 缺陷定位与修复：最小改动、风险评估、验证与修复报告 |
| `code-review` | 代码评审 |
| `refactor` | 代码重构：拆分、老代码治理 |
| `code-write-doc` | 文档同步：`*_DOC.md` 与代码对齐 |
| `git-commit` | Git 提交与 push |
| `workflow` | 统一工作流入口 |
| `goal-contract` | 原生 Goal 的目标、范围、P0/P1/P2 和验证证据契约 |

### 市场 skill（`~/.agents/skills/`，经 `.cursor/skills` 软链暴露）

| Skill | 用途 |
|-------|------|
| `wecom-robot` | 企微机器人 Webhook（可选） |

## 3. 按需 Skill

按需 skill 放在 `skills-on-demand/`，不默认暴露。当前为空，需要时再补（例如前端 Figma 工作流、本地 E2E）。

## 4. 不纳入本仓的 skill

嗒嗒 / DeepTrip 专用能力不拷贝：`jean`、`config-center`、`hj-local-logs`、`skyeye`、`tiexin-doc`、`local-start`。浮屿记不走同程 Jean / 配置中心。
