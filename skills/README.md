# skills

从 `dada-agent` 同步的流程类 skill，并按浮屿记场景调整了路由。

- 流程类 skill：本目录 + `.cursor/skills` 软链
- 浮屿记专项：`cross-platform-delivery`（iOS/Android/后端跨仓交付）
- 运维类 skill：可选市场版 `wecom-robot`，见 `doc/project/SkillRouting_DOC.md`

## 分层

- `skills/`：默认激活。高频、写错代价高的跨仓约定。
- `skills-on-demand/`：不默认激活。用户明确提到名称或意图时再读。

## 原则

- 端内实现规范继续留在各业务仓（iOS / Android / Web / 后端各自的 `CLAUDE.md`）。
- 同名 skill 优先用本仓版本。
- 新增或下线 skill 后，同步更新 `PROJECT_GUIDE.md` 的 Skill 路由和 `doc/project/SkillIndex_DOC.md`。
