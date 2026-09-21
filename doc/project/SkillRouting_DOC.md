# Skill 路由（浮屿记）

- 更新时间：2026-09-21
- 用途：说明项目 skill、市场 skill、未纳入本仓的能力之间的选用关系

[TOC]

## 1. 选用原则

1. **流程类 skill**（需求、方案、编码、评审、文档、git）：用本仓 `skills/` 项目版。
2. **跨端复刻 / 双端接入**：用本仓 `cross-platform-delivery`。
3. **同名冲突**：项目级优先于 `~/.agents/skills/` 市场版。
4. **不要用嗒嗒仓里的 Jean / 配置中心 / 天网 skill** 来操作浮屿记。

## 2. 路由表

| 意图 | 使用 | 来源 |
| --- | --- | --- |
| 需求分析 | `requirement-analysis` | 本仓 |
| 技术方案 | `system-design` | 本仓 |
| 编码规划 | `plan-work` | 本仓 |
| iOS→Android 复刻 / 后端双端接入 | `cross-platform-delivery` | 本仓 |
| 缺陷修复 | `fix-bug` | 本仓 |
| 代码评审 | `code-review` | 本仓 |
| Git 提交 | `git-commit` | 本仓 |
| 企微机器人 Webhook | `wecom-robot` | 市场 skill（可选） |

## 3. Agent 暴露路径

| 宿主 | 默认激活目录 |
| --- | --- |
| Cursor | `fuyuji_robot/.cursor/skills` + `~/.cursor/skills` |
| Claude Code | `fuyuji_robot/.claude/skills` |
| Codex | `fuyuji_robot/.codex/skills` |

## 4. 业务仓入口

| 端 | 端内规范 |
| --- | --- |
| iOS | `DiguProject/CLAUDE.md` |
| Android | `fuyuji-android-module/CLAUDE.md` |
| Web | `dailyhole-web/CLAUDE.md` |
| 后端 | `dailyhole/CLAUDE.md`、`dailyhole/README.md` |
