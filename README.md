# fuyuji_robot

浮屿记开发助手仓，对应嗒嗒的 `dada-agent`。

本仓库**不是**业务 monorepo。iOS / Android / Web / 后端继续各自独立 git。这里只放跨仓地图、本地路径约定、Agent 启动规则和 skills。

## 怎么打开

用 Cursor 打开本目录下的 `fuyuji_robot.code-workspace`，会同时载入 5 个 folder：

- `fuyuji_robot`（本仓）
- `ios` → `../DiguProject`
- `android` → `../fuyuji-android-module`
- `web` → `../dailyhole-web`
- `backend` → `../dailyhole`

不要只打开空的 `fuyuji_robot` 文件夹做跨仓开发。单端开发仍可单独打开对应业务仓。

## 本机初始化

```bash
cp doc/project/LocalPaths_TEMPLATE.md doc/project/LocalPaths_LOCAL.md
# 按本机路径改 LocalPaths_LOCAL.md（该文件已 gitignore）
./scripts/link-apps.sh   # 可选：apps/ 软链，给 Claude Code / Codex 读业务仓
```

仓库地图：`doc/project/FuyujiOverview_DOC.md`  
Agent 入口：`PROJECT_GUIDE.md`（`AGENTS.md` / `CLAUDE.md` 软链到它）  
Skill 索引：`doc/project/SkillIndex_DOC.md`

## 不要放进本仓的东西

- 4 个业务仓的源码（保持平级目录，或只用 gitignored 的 `apps/` 软链）
- 本机绝对路径（写在 `LocalPaths_LOCAL.md`）
- 密钥、`.env`、签名文件
