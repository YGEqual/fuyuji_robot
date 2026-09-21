# 浮屿记项目 Git 仓库地址

> 更新时间：2026-09-21
> 用途：团队成员 clone 仓库的统一入口

## 开发助手

| 仓库 | SSH Clone | 职责 |
|------|-----------|------|
| `fuyuji_robot` | `git@github.com:YGEqual/fuyuji_robot.git` | 跨仓文档、路径约定、Agent 规则 |

## 客户端 / 前端

| 仓库 | SSH Clone | 职责 |
|------|-----------|------|
| `DiguProject` | `git@github.com:YGEqual/DiguProject.git` | iOS 客户端 |
| `fuyuji-android-module` | `git@github.com:YGEqual/fuyuji-android-module.git` | Android 客户端 |
| `dailyhole-web` | `git@github.com:YGEqual/dailyhole-web.git` | 管理后台 |

## 后端

| 仓库 | SSH Clone | 职责 |
|------|-----------|------|
| `dailyhole` | `git@github.com:YGEqual/dailyhole.git` | 浮屿记后端（C 端 + admin） |

## 快速 Clone（平级目录）

业务仓与 `fuyuji_robot` 放在同一父目录，不要 clone 进 `fuyuji_robot` 里面。

```bash
mkdir -p ~/Desktop/TCProject
cd ~/Desktop/TCProject

git clone git@github.com:YGEqual/fuyuji_robot.git
git clone git@github.com:YGEqual/DiguProject.git
git clone git@github.com:YGEqual/fuyuji-android-module.git
git clone git@github.com:YGEqual/dailyhole-web.git
git clone git@github.com:YGEqual/dailyhole.git
```

HTTP 方式把 `git@github.com:` 换成 `https://github.com/`。

clone 完成后：

```bash
cd fuyuji_robot
cp doc/project/LocalPaths_TEMPLATE.md doc/project/LocalPaths_LOCAL.md
# 按本机路径填写 LocalPaths_LOCAL.md
./scripts/link-apps.sh   # 可选
```
