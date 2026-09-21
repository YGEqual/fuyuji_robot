---
name: cross-platform-delivery
description: >-
  浮屿记跨端交付编排：iOS 功能复刻到 Android、后端 API 双端接入、管理后台联调。
  触发词包括「跨端」「iOS 复刻 Android」「双端接入」「后端接口客户端对接」「对齐 iOS」。
metadata:
  short-description: iOS/Android/后端跨仓交付
---

# cross-platform-delivery（跨端交付）

[TOC]

## 定位与边界

本 skill 编排 **backend → iOS → Android**，必要时带上 **web 管理后台**。

**本 skill 管：**

- 跨仓编码顺序、双端 API 对齐、iOS→Android 复刻 checklist
- 交付物清单与门禁（字段、状态、截图、联调）

**本 skill 不管：**

- 需求是什么 → `requirement-analysis`
- 技术方案与接口设计 → `system-design`
- 编码步骤拆分 → `plan-work`
- 单仓代码风格 → 各仓 `CLAUDE.md` + `coding-standards`
- 真实 E2E 细节 → `integration-test`

## 架构速览

```text
fuyuji_robot（本 skill：路由 + checklist）
    │
    ├── iOS DiguProject（Source of Truth：先实现）
    │       └── UI / 字段 / 交互以 iOS 为准
    │
    ├── Android fuyuji-android-module（消费 iOS + 后端）
    │       └── 对照 docs/ios-ui-spec.md 与 iOS 源码
    │
    ├── backend dailyhole（接口事实标准：router / model / controller）
    │
    └── web dailyhole-web（仅 /api/admin/*，不做 C 端复刻）
```

## 仓库与路径

业务仓路径以 `doc/project/LocalPaths_LOCAL.md` 为准（gitignore）。沟通时用仓库简称：

| 简称 | 仓库 | 端内 Agent 入口 |
| --- | --- | --- |
| ios | `DiguProject` | `CLAUDE.md` |
| android | `fuyuji-android-module` | `CLAUDE.md` |
| web | `dailyhole-web` | `CLAUDE.md` |
| backend | `dailyhole` | `CLAUDE.md` |

打开 `fuyuji_robot.code-workspace` 确保 5 仓在同一工作区。

## 编码顺序

按任务类型选一条主路径，不要四端同时开写。

### 模式 A：iOS 新功能 → Android 复刻

1. 后端先有接口（或确认已有）→ `dailyhole/router` + `model`
2. iOS 先落地体验和字段
3. 把页面结构、状态、接口写进 Android `docs/ios-ui-spec.md`（或本需求对应小节）
4. Android 按 iOS + spec 复刻，走 MVVM / Repository
5. 双端对着同一环境（本地 / QA / 生产）验收

### 模式 B：后端新接口 → 双端接入

1. 在 `dailyhole` 定路径、请求体、响应壳、鉴权
2. iOS 用 `APIClient` + 业务 API 封装接入
3. Android 用 Retrofit + Repository 接入，模型字段对齐 iOS Codable
4. 需要运营能力时，再补 `dailyhole-web` 的 `/api/admin/*`

### 模式 C：只改管理后台

只动 `dailyhole` 的 admin 路由 + `dailyhole-web`。不要把 admin API 接到 App。

## iOS → Android 翻译

以 Android 仓 `CLAUDE.md` 为准，这里只列跨仓容易漏的：

| iOS | Android |
| --- | --- |
| `UIViewController` | `Activity` / `Fragment` |
| SnapKit | ConstraintLayout XML |
| `UITableView` / `UICollectionView` | RecyclerView + ListAdapter |
| `UserDefaults` / `AuthSession` | `UserPrefs` |
| Alamofire `APIClient` | Retrofit + `loadHttp` |
| `kFontR/M/S`、`kColor` | `res/values` / 设计常量 |
| `Assets.xcassets/<组>/<name>.imageset` `@2x/@3x` | `drawable-xhdpi` / `drawable-xxhdpi`，文件名 snake_case |

不要把 iOS 代码逐字翻译成 Android 反模式。View 层禁止直连 `ApiService`。

图标：从 iOS imageset 拷 `@2x` / `@3x` PNG，不要只拷一份再拉伸。

## API 对齐

- 响应壳：`{ code, message, data }`，`code == 200` 为成功
- C 端：`Authorization: Bearer <user jwt>`
- 管理端：`Authorization: Bearer <admin jwt>`，`scope=admin`，路径 `/api/admin/*`
- 路由事实标准：`dailyhole/router/router.go`
- iOS 封装：`DiguProject/Tools/Network/APIClient.swift`、`Tools/Login/DailyHoleAuthAPI.swift`
- Android 封装：`app/.../http/`、`repository/`

改接口时三端一起核：路径、字段名、空值、分页、错误文案。

## 联调环境

见 `doc/project/FuyujiLocalStart_DOC.md`。

| 端 | 切环境位置 |
| --- | --- |
| iOS | `APIClient.swift` → `APIBaseHost` |
| Android | `Config.kt` → `EnvConfig` |
| Web | `.env.*` / `npm run dev:qa` / `dev:online` |

同一轮联调不要一端打生产、一端打本地。

## 验收清单

逐项核对，缺一项就不要说“对齐了”：

- [ ] 后端路径与字段已落到 `router` / `model`，而不是口头约定
- [ ] iOS 主路径可走通（成功 / 空态 / 错误态）
- [ ] Android 对照 iOS 截图或 `docs/ios-ui-spec.md`，结构未私自增删
- [ ] 双端请求同一 host、同一账号体系
- [ ] 列表分页、点赞/删除等写操作副作用一致
- [ ] 管理后台若涉及，只走 `/api/admin/*`

更细的复刻项见 `references/ios-android-alignment-checklist.md`。
