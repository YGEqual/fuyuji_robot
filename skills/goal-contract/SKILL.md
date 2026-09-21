---
name: goal-contract
description: 为长时、跨会话或复杂开发目标定义可验证的目标契约，并交给当前宿主的原生 Goal 模式执行。用户提到 /goal、goal:、goal-driven、持续执行或“做到验收为止”时使用；不创建自研状态机，也不替代普通任务的实施计划。
metadata:
  short-description: 原生 Goal 的 DeepTrip 目标契约与验收规则
  triggers:
    - "/goal"
    - "goal:"
    - "goal-driven:"
    - "持续执行"
    - "做到验收为止"
---

# Goal Contract

## 定位

本 Skill 只负责把复杂目标整理成可执行、可验证的契约。长时间运行、暂停、恢复、状态和生命周期由当前宿主的原生 Goal 模式负责。

禁止启动 `workflow_sdk.py -t goal-driven`、Watchdog 或其他第二套 Goal 状态机。宿主没有原生 Goal 能力时，只产出目标契约并说明能力边界，不自行恢复旧引擎。

## 路由

- 目标、范围或验收仍模糊：先使用 `/plan` 澄清，确认后再启动 Goal。
- 目标已经明确，且用户明确要求 `/goal`、`goal:` 或持续执行：整理契约后直接调用原生 Goal。
- 用户只要求方案或计划：停在计划，不启动 Goal。
- 普通单轮可完成任务：直接执行，不放大成 Goal。

## 目标契约

原生 Goal 的目标文本是唯一运行契约，至少包含：

1. **Outcome**：完成后用户或系统能观察到什么结果。
2. **Scope**：允许修改的仓库、目录、模块和明确不做的内容。
3. **Constraints**：兼容性、权限、环境、安全、数据和生产操作边界。
4. **Criteria**：P0/P1/P2 成功标准；P0/P1 全部通过才可完成，P2 不阻塞但要报告。
5. **Verification**：每条 P0/P1 对应可重复执行的命令、断言和证据位置。
6. **Stop conditions**：完成、需要人决策、权限不足、真实依赖不可用、不可逆操作前暂停。

一个合格标准必须能客观判断 PASS/FAIL。写不出验证方式时，继续澄清或拆分，不进入执行。

## 执行约束

- 先读取项目说明、相关需求/方案、当前 worktree、分支和既有 `PROCESS.md`。
- 使用任务匹配的项目 Skill；编码遵循 `coding-standards`，验收遵循 `integration-test`。
- 每完成一个子目标立即运行对应验证，不把失败积压到最后。
- 需要阶段门禁时直接运行 `scripts/checkpoint/run-checkpoint.sh`；Checkpoint 只验收，不拥有运行状态。
- 长任务可维护迭代目录中的 `PROCESS.md`，记录已完成、失败方案、卡点、决策和下一步。它是交接与审计记录，不驱动 Goal 生命周期。
- 不通过修改 Criteria、删除失败 case、放宽断言或输出完成字符串来宣告成功。
- 生产部署、生产写入、密钥修改、数据删除和其他不可逆操作仍需对话中的明确授权；Goal 不扩大权限。

## 完成判断

只有同时满足以下条件才能完成 Goal：

- 所有 P0/P1 的验证命令实际通过；
- 当前代码和运行版本可确认；
- 适用的用户结果、接口语义、日志/trace、数据和外部副作用均有证据；
- P0/P1 问题已修复并重跑受影响回归；
- 未完成 P2、阻塞项、风险和生产待办已明确记录。

真实条件不足时保持 Goal 未完成或标记阻塞，并给出缺失条件和可继续执行的命令。

## 与 Workflow 的关系

`workflow` 仍可编排 default、bugfix、hotfix 的阶段 SOP。原生 Goal 可以按需调用这些阶段对应的 Skill 和 Checkpoint，但不得嵌套启动另一个长时运行编排器。
