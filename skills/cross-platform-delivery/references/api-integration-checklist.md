# 后端 API 双端接入清单

用于 `cross-platform-delivery` 模式 B。

## 后端

- [ ] 路径已注册在 `dailyhole/router/router.go`
- [ ] 请求/响应结构在 `model/`，字段 json tag 稳定
- [ ] 鉴权：C 端 user JWT，管理端 admin JWT，不要混用
- [ ] 错误：走统一 `{ code, message, data }`，文案可给用户看
- [ ] 上传类接口写清 COS 目录与字段名（`files` / `audio`）

## iOS

- [ ] 走 `APIClient.shared.request`，不另起一套 session
- [ ] Codable 字段与后端 json tag、Android 模型同名
- [ ] 401 走现有登出逻辑

## Android

- [ ] Retrofit service + Repository，ViewModel 不直接打网
- [ ] Gson 字段与 iOS / 后端对齐
- [ ] 401 清 `UserPrefs` 并回登录

## Web（仅 admin）

- [ ] 只接 `/api/admin/*`
- [ ] Token 走现有 axios 拦截器
- [ ] 不要把 C 端接口接到后台页面，也不要把 admin 接口接到 App
