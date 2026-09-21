# 仓库本地路径模板

> 这份文件用于记录「我本机上浮屿记各仓库的本地路径」。
>
> 正确做法：复制为 `doc/project/LocalPaths_LOCAL.md`，只在本机维护（已加入 `.gitignore`）。
>
> ```bash
> cp doc/project/LocalPaths_TEMPLATE.md doc/project/LocalPaths_LOCAL.md
> ```

## 1. 开发助手（本仓库）

- `fuyuji_robot`：`/Users/xxx/Desktop/TCProject/fuyuji_robot`

## 2. 浮屿记多仓库（按仓库名）

| 仓库 | 简称 | 角色 | 本地路径（示例） | 备注 |
| --- | --- | --- | --- | --- |
| `DiguProject` | ios | 客户端 | `/Users/xxx/Desktop/TCProject/DiguProject` | Swift / UIKit，打开 `.xcworkspace` |
| `fuyuji-android-module` | android | 客户端 | `/Users/xxx/Desktop/TCProject/fuyuji-android-module` | Kotlin / MVVM |
| `dailyhole-web` | web | 管理后台 | `/Users/xxx/Desktop/TCProject/dailyhole-web` | Vue 3 + Vite |
| `dailyhole` | backend | 后端 | `/Users/xxx/Desktop/TCProject/dailyhole` | Go 1.25 |

## 3. 各仓库基准分支（提测 diff 用）

填写本机常用的对照分支。开发分支名从需求文档获取，不要用 `git branch --show-current` 推断。

| 仓库 | 基准分支 |
| --- | --- |
| `DiguProject` | master |
| `fuyuji-android-module` | master |
| `dailyhole-web` | master |
| `dailyhole` | master |
