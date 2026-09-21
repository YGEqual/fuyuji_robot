---
name: workflow
description: 阶段工作流入口（多仓通用 SOP）。使用 Python SDK v3 编排 default、bugfix 和 hotfix；长时复杂目标转交宿主原生 Goal，并由 goal-contract 约束验收。用户提到 workflow、工作流、workflow状态或明确要求按阶段执行时使用。
metadata:
  short-description: 阶段 SOP + 原生 Goal + Checkpoint
  triggers:
    - "workflow:"
    - "workflow状态"
---

# Workflow - 统一工作流入口

## 触发规则

| 用户表达 | 执行方式 |
|----------|----------|
| `workflow: 需求描述` | SDK v3 + `default` 模板 |
| `/goal 目标` / `goal: 目标` / `goal-driven: 目标` | `goal-contract` + 宿主原生 Goal |
| “修复 Bug”并明确使用工作流 | SDK v3 + `bugfix` 模板 |
| “线上紧急修复”并明确使用工作流 | SDK v3 + `hotfix` 模板 |
| `workflow状态` | 查看 `.workflow_sdk` 状态 |
| `/goal` 或 Goal 状态 | 查看宿主原生 Goal 状态 |

阶段工作流入口：

```bash
# 推荐：使用本仓 venv（Python 3.12 + claude-agent-sdk）
bash scripts/workflow/run.sh <command>

# 或直接指定 venv Python
.venv-workflow/bin/python scripts/workflow/workflow_sdk.py <command>
```

前置：本仓已提供 `.venv-workflow/`（gitignore）。缺失时见 `scripts/workflow/run.sh` 内提示安装。

`workflow_sdk.py` 只负责阶段 SOP。长时目标的状态、暂停、恢复和完成生命周期由宿主原生 Goal 负责。禁止新增 Shell/Python/tmux/cmux Goal 状态机。

## 快速开始

```bash
# 默认全流程
python scripts/workflow/workflow_sdk.py init "需求描述"

# 阶段模板
python scripts/workflow/workflow_sdk.py init "修复问题" -t bugfix
python scripts/workflow/workflow_sdk.py init "线上故障" -t hotfix

# 指定阶段
python scripts/workflow/workflow_sdk.py init "需求" coding,evaluator

# 状态和恢复
python scripts/workflow/workflow_sdk.py status
python scripts/workflow/workflow_sdk.py watch
python scripts/workflow/workflow_sdk.py resume
python scripts/workflow/workflow_sdk.py templates
```

## 统一组件关系

```text
workflow_sdk.py
  ├── sdk/workflows/*.yaml：阶段模板
  ├── PROCESS.md：跨会话上下文
  ├── Checkpoint：阶段门禁
  └── state/heartbeat/log：阶段状态与监控

宿主原生 Goal
  ├── 长时目标生命周期、暂停和恢复
  └── goal-contract：Outcome、边界、Criteria 和验证证据

subagent / 通用 tmux
  └── 只承载独立并行任务和长进程，由主 Agent 收口
```

`PROCESS.md` 和 Checkpoint 不拥有 Goal 状态；它们分别承担交接记录和质量门禁。

## Default 十阶段

| # | 阶段 | Skill | 完成要求 |
|---|------|-------|----------|
| 1 | 需求分析 | `requirement-analysis` | 需求与目标验证追踪矩阵完整 |
| 2 | 技术方案 | `system-design` | 架构、数据、风险、回滚和评估明确 |
| 3 | 编码规划 | `plan-work` | 任务映射到追踪矩阵子目标 |
| 4 | 编码 + 真实 E2E | `coding-standards` + `integration-test` | 每个子目标立即运行真实链路 |
| 5 | 业务验证 | `evaluator` | 追踪矩阵逐项 PASS/FAIL |
| 6 | 代码评审 | `code-review` | P0/P1 修复后重新验证 |
| 7 | 交付文档 | `dev-handoff` | 提测和分受众联调文档 |
| 8 | 编译 | `build` | 涉及应用全部编译通过 |
| 9 | 真实 E2E 回归 | `integration-test` | 响应、日志、数据和副作用证据完整 |
| 10 | 部署准备 | 手动/Jean | 只输出步骤，不自动生产发布 |

## 模板选择

| 模板 | 用途 | 停止条件 |
|------|------|----------|
| `default` | 正常新需求 | 10 阶段完成 |
| `bugfix` | 明确 Bug、小改动 | 修复、验证、评审、回归完成 |
| `hotfix` | 线上紧急故障 | 最短路径完成，风险与未验证项明确 |

## 真实 E2E 硬性约束

```text
当前 worktree/分支和 Git SHA
  -> 官方方式启动当前代码
  -> 确认进程、端口和健康状态
  -> 运行业务仓库内长期保留的 E2E 脚本
  -> 断言用户结果和接口语义
  -> 按 run_id/traceId 核对日志与下游
  -> 核对 DB/Redis/ES/MQ/异步终态和外部副作用
  -> 失败则修复、重启、重跑
```

以下行为一律不算真实验收：

- Mock 下游、数据库或副作用后宣称 E2E 通过；
- 用单元测试、覆盖率、静态阅读代替；
- 只看 HTTP 200、业务码或进程未崩溃；
- 使用一次性请求且不保留回归脚本；
- 伪造响应、日志、trace 或数据证据。

真实条件不足时必须输出“真实 E2E 未完成”，说明阻塞和继续验证命令。

## 原生 Goal

复杂、跨仓库或长时间任务使用 `goal-contract` 后启动宿主原生 Goal：

```text
plan（目标不清时）
  -> goal-contract
  -> 原生 Goal
  -> 评估基线
  -> 拆解并执行
  -> 每个子任务立即验证
  -> 不通过继续修复或换方案
  -> P0/P1 全部通过才停止
```

Goal 文本是唯一运行契约；`PROCESS.md` 只记录进度、失败方案、决策和下一步。生产部署和不可逆操作仍需人工确认。

## 并行任务

适合并行：

- 多仓库互不冲突的修改；
- 独立调研和交叉评审；
- 服务启动、测试、日志等长进程。

不适合并行：

- 修改同一文件；
- 共用不可隔离状态；
- 存在严格前置依赖；
- 最终集成、E2E 和验收判断。

主 Agent 必须在分派前明确输入、输出、禁止范围和验证标准，结果返回后交叉检查并统一验收。并行任务不得写同一文件或共享不可隔离状态。

## 自定义模板

在 `scripts/workflow/sdk/workflows/` 新增 YAML，通过 `-t` 选择。禁止通过新增编排器扩展流程。

模板字段、钩子和示例见：

- `scripts/workflow/sdk/README.md`；
- `doc/project/dev-guide/SDKWorkflowGuide_DOC.md`。

## 相关文档

- [WorkflowSystem_DOC.md](../../doc/project/dev-guide/WorkflowSystem_DOC.md)：统一架构；
- [SDKWorkflowGuide_DOC.md](../../doc/project/dev-guide/SDKWorkflowGuide_DOC.md)：详细使用；
- [IterationSOP_DOC.md](../../doc/project/IterationSOP_DOC.md)：迭代流程；
- `skills/goal-contract/SKILL.md`：原生 Goal 的目标与验收契约；
- `skills/integration-test/SKILL.md`：真实 E2E；
- `skills-on-demand/tmux/SKILL.md`：通用并行和长进程工具。
