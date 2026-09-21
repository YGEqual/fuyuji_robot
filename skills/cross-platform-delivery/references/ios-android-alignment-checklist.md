# iOS → Android 复刻对齐清单

用于 `cross-platform-delivery` 模式 A。在 Android 提交前逐项核对。

## 对照来源

- [ ] 已读 iOS 对应页面（`DiguProject/DiguProject/UI/AppUI/`）
- [ ] 已读 Android `docs/ios-ui-spec.md` 中本页相关段落；没有则先补再写代码
- [ ] 接口以 `dailyhole/router/router.go` + iOS 请求封装为准

## UI 与交互

- [ ] UI 结构树与 iOS 一致（不私自增删区块）
- [ ] 颜色/字号/间距来自资源或设计常量，无硬编码魔法数
- [ ] 状态：loading / empty / error / 列表数据与 iOS 一致
- [ ] 点击、刷新、导航、返回与 iOS 一致
- [ ] 边界态：空态、错误态、未登录、断网

## 架构与代码规范

- [ ] MVVM：ViewModel + StateFlow/LiveData
- [ ] 网络经 Repository，View 不直连 Api
- [ ] 未使用 Jetpack Compose（基线 XML + ViewBinding）
- [ ] 图标：iOS `@2x` → `drawable-xhdpi`，`@3x` → `drawable-xxhdpi`
- [ ] 弹窗走 `WarmDialog`（系统权限 / 打印 / 日期时间选择器除外）

## 联调

- [ ] `Config.kt` 与 iOS `APIBaseHost` 指向同一环境
- [ ] 同一账号能在双端看到同一份数据
- [ ] `./gradlew :app:assembleOtherDebug` 可编译
