# 浮屿记是什么（仓库总览）

- 更新时间：2026-09-21
- 用途：跨仓协作时的仓库地图、联调链路、本地工作区约定

[TOC]

## 1. 定位

浮屿记不是单仓库项目，而是一组围绕「日记 / 树洞 / 情绪岛 / 失眠电台 / 会员」的多仓库协作工程。对外域名是 `moodnote.cn`。

**本仓 `fuyuji_robot` 的职责**：

- 提供统一文档入口和 Agent 启动规则
- 记录仓库地图、Git 地址、本机路径约定
- **实际业务代码在 4 个独立仓库**，路径见 [LocalPaths_TEMPLATE.md](LocalPaths_TEMPLATE.md)

## 2. 仓库地图

| 仓库 | 简称 | 角色 | 职责 |
| --- | --- | --- | --- |
| `fuyuji_robot` | agent | 助手 | 跨仓文档、路径表、skills。不是业务仓 |
| `DiguProject` | ios | 客户端 | 浮屿记 iOS（Swift / UIKit）。产品体验与字段含义的 Source of Truth。端内规范：`CLAUDE.md` |
| `fuyuji-android-module` | android | 客户端 | 浮屿记 Android（Kotlin / MVVM / XML）。iOS 复刻。端内规范：`CLAUDE.md` |
| `dailyhole-web` | web | 管理后台 | Vue 3 + Vite + Element Plus。运营后台，不是 C 端 |
| `dailyhole` | backend | 后端 | Go 1.25 + Gin + GORM(MySQL) + JWT。C 端 `/api/*` + 管理 `/api/admin/*` |

### 2.1 后端模块（`dailyhole`）

- `controller/`：HTTP 入参、统一响应
- `service/`：业务逻辑
- `model/`：数据模型与请求/响应结构
- `router/`：路由注册
- `pkg/`：基础设施（db、jwt、COS、日志）
- `config/`：YAML 配置

C 端主要域：认证、日记、树洞、情绪岛、电台、关注/拉黑、消息、邀请码、IAP、待办、上传。

管理后台域：用户、日记、树洞、举报、反馈、话题、兑换码、UGC 词库。

## 3. 典型联调链路

```text
iOS / Android
        │
        ▼
dailyhole  /api/*          （C 端，JWT scope=user）
        │
        ├── 认证 / 资料 / 头像
        ├── 日记 / 树洞 / 情绪岛 / 电台
        ├── 关注 / 拉黑 / 消息 / 待办
        └── 邀请码 / IAP / 上传（COS）

运营后台 dailyhole-web
        │
        ▼
dailyhole  /api/admin/*    （管理端，JWT scope=admin）
```

域名（以当前代码为准）：

| 环境 | API | Web 管理后台 |
| --- | --- | --- |
| 本地 | `http://localhost:8080` | `http://localhost:5173`（vite proxy → 8080） |
| QA | `https://qa.moodnote.cn` | `dailyhole-web` `dev:qa` / `build:qa` |
| 生产 | `https://moodnote.cn` | `dailyhole-web` production |

客户端切环境：

- iOS：`DiguProject/Tools/Network/APIClient.swift` 的 `APIBaseHost`
- Android：`app/src/main/java/com/fuyuji/app/Config.kt` 的 `EnvConfig`

## 4. 本地目录与多仓库工作区约定

### 4.1 结论

- 不把 4 个业务仓搬进 `fuyuji_robot`，也不再 clone 一份
- 同一台机器上尽量平级放置，方便沟通和 Cursor 多根工作区
- 绝对路径因人而异，沟通时用「仓库名 + 相对路径」

### 4.2 推荐结构（本机已按此放置）

```text
<your_workspace>/
  fuyuji_robot/               # 本仓库：浮屿记开发助手
  DiguProject/                # iOS
  fuyuji-android-module/      # Android
  dailyhole-web/              # 管理后台
  dailyhole/                  # 后端
```

Cursor：打开 `fuyuji_robot/fuyuji_robot.code-workspace`。

可选：`fuyuji_robot/apps/` 下对上述 4 仓做 gitignored 软链，给只认当前目录的 Agent（Claude Code / Codex）读源码。不要把 `apps/` 提交进 git。

### 4.3 沟通方式

- 用仓库名 + 相对路径，例如 `DiguProject/DiguProject/Tools/Network/APIClient.swift`
- 链到 Git 仓库 / PR / commit
- 不依赖某个固定绝对路径

## 5. 按角色最少关心哪些仓

### 5.1 客户端（iOS / Android）

- 必关心：对应客户端仓 + `dailyhole`（`/api/*`）
- 跨端复刻：iOS 是 Source of Truth，Android 对照 `docs/ios-ui-spec.md` 与 iOS 源码

### 5.2 Web 管理后台

- 必关心：`dailyhole-web` + `dailyhole`（`/api/admin/*`）
- 与 C 端用户体系隔离（JWT `scope=admin`）

### 5.3 后端

- 必关心：`dailyhole`
- 视需求：各客户端如何调 `/api/*`，后台如何调 `/api/admin/*`
