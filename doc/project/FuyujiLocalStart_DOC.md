# 浮屿记本地启动指引

- 更新时间：2026-09-21
- 说明：跨仓联调时先看本页，细节以各业务仓 `CLAUDE.md` / `README.md` 为准

[TOC]

## 1. 常用组合

| 要验证什么 | 建议启动 | 依赖环境 |
| --- | --- | --- |
| 后端 API | `dailyhole` `go run main.go` | 本机 MySQL，库名 `dailyhole` |
| 管理后台 | `dailyhole-web` `npm run dev` | 后端 :8080（vite proxy） |
| iOS | `DiguProject.xcworkspace` | 把 `APIBaseHost` 指到本机或 QA |
| Android | `fuyuji-android-module` 编译安装 | `Config.kt` 切 `DEV_LAN` / `LOCAL_EMULATOR` |

路径见 `doc/project/LocalPaths_LOCAL.md`。

## 2. 后端（`dailyhole`）

- Go 1.25 + Gin + GORM + MySQL
- 默认监听 `http://localhost:8080`
- 首次启动会自动建表；`admins` 为空时写入默认管理员

```bash
# 一次性
mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS dailyhole CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
cd dailyhole
go mod tidy
go run main.go
```

配置：`config/config.yaml`（端口、MySQL、JWT）。生产部署见 `dailyhole/docs/部署文档.md`。

默认管理员（仅本地 / 空库）：

- 账号：`dailyhole`
- 密码：`Dailyhole2026888`

登录后建议立刻改掉。不要把这组账号写进客户端或对外文档以外的地方。

## 3. Web 管理后台（`dailyhole-web`）

```bash
cd dailyhole-web
npm install   # 首次
npm run dev   # http://localhost:5173 ，/api 与 /uploads 代理到 :8080
```

环境：

| 命令 | 说明 |
| --- | --- |
| `npm run dev` | 本地，默认打 `localhost:8080` |
| `npm run dev:qa` | 直连 `https://qa.moodnote.cn` |
| `npm run dev:online` | 直连 `https://moodnote.cn` |

变量见仓库 `.env.example`。

## 4. 客户端

### iOS（`DiguProject`）

- 打开 `DiguProject.xcworkspace`（不要只开 `.xcodeproj`）
- 首次：`pod install`
- 切环境：`DiguProject/Tools/Network/APIClient.swift` 的 `APIBaseHost`
  - 模拟器本机：`http://127.0.0.1:8080`
  - 真机：Mac 内网 IP，如 `http://192.168.x.x:8080`
  - QA / 生产：`https://qa.moodnote.cn` / `https://moodnote.cn`
- UI 常量：`DiguProject/Tools/Configs/CommonConst.swift`（`kFontR/M/S`、`kColor`）

### Android（`fuyuji-android-module`）

- 打开 `fuyuji-android-module`，单 `app` 模块
- 切环境：`app/src/main/java/com/fuyuji/app/Config.kt` 的 `EnvConfig`
  - `DEV_LAN`：局域网 IP
  - `LOCAL_EMULATOR`：`http://10.0.2.2:8080/`
  - `PRODUCT`：`https://moodnote.cn/`
- 常用构建：`./gradlew :app:assembleOtherDebug`

## 5. 联调域名

| 端 | 地址 |
| --- | --- |
| 本地 API | `http://localhost:8080` |
| QA | `https://qa.moodnote.cn` |
| 生产 | `https://moodnote.cn` |

响应壳统一为 `{ code, message, data }`。C 端与管理端 JWT 隔离（`scope=user` / `scope=admin`）。

详见 `doc/project/FuyujiOverview_DOC.md`。
