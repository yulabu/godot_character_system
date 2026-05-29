# 角色操作系统使用指南

## 快速开始

### 1. 打开 Godot 编辑器

在 Godot 编辑器中打开项目 `角色操作系统2.0`

### 2. 配置动画

在 `AnimatedSprite2D` 节点的 `SpriteFrames` 中添加以下动画：

| 动画名称 | 描述 | 帧数 |
|----------|------|------|
| idle_down | 待机（朝下） | 1-4帧 |
| idle_up | 待机（朝上） | 1-4帧 |
| idle_left | 待机（朝左） | 1-4帧 |
| idle_right | 待机（朝右） | 1-4帧 |
| run_down | 移动（朝下） | 1-6帧 |
| run_up | 移动（朝上） | 1-6帧 |
| run_left | 移动（朝左） | 1-6帧 |
| run_right | 移动（朝右） | 1-6帧 |
| dash_down | 冲刺（朝下） | 1-3帧 |
| dash_up | 冲刺（朝上） | 1-3帧 |
| dash_left | 冲刺（朝左） | 1-3帧 |
| dash_right | 冲刺（朝右） | 1-3帧 |
| attack_down | 攻击（朝下） | 1-4帧 |
| attack_up | 攻击（朝上） | 1-4帧 |
| attack_left | 攻击（朝左） | 1-4帧 |
| attack_right | 攻击（朝右） | 1-4帧 |
| skill_down | 技能（朝下） | 1-4帧 |
| skill_up | 技能（朝上） | 1-4帧 |
| skill_left | 技能（朝左） | 1-4帧 |
| skill_right | 技能（朝右） | 1-4帧 |
| hit_down | 受击（朝下） | 1-2帧 |
| hit_up | 受击（朝上） | 1-2帧 |
| hit_left | 受击（朝左） | 1-2帧 |
| hit_right | 受击（朝右） | 1-2帧 |
| death | 死亡 | 1-4帧 |

### 3. 按键说明

| 按键 | 功能 |
|------|------|
| W | 向上移动 |
| A | 向左移动 |
| S | 向下移动 |
| D | 向右移动 |
| J | 攻击 |
| K | 技能 |
| L | 冲刺/闪避 |

### 4. 运行测试

按 `F5` 运行项目，测试角色操作。

## 状态优先级

```
DEATH(100) > HIT(50) > SKILL(30) > ATTACK(30) > DASH(20) > MOVING(10) > IDLE(0)
```

## 状态机架构

```
StateMachine (状态机核心)
├── IdleState (待机)
├── MoveState (移动)
├── DashState (冲刺/闪避)
├── AttackState (攻击)
├── SkillState (技能)
├── HitState (受击)
└── DeathState (死亡)
```

## 扩展指南

### 添加新状态

1. 在 `states/` 目录创建新脚本，继承 `State`
2. 在 `state_machine.gd` 的 `StateKey` 枚举中添加新状态
3. 在 `world.tscn` 的 `StateMachine` 节点下添加新状态节点
4. 在 `state_machine.gd` 的 `_get_state_key_from_node_name()` 中添加映射

### 自定义闪避判定

在 `character_controller.gd` 的 `check_dodge()` 函数中实现你的闪避判定逻辑。

### 配置受击打断

在 `HitState` 节点的属性中设置 `interruptible` 为 `true`，允许受击状态被更高优先级的状态打断。
