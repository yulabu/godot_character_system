class_name StateMachine extends Node

## 状态机核心，管理状态注册、切换、更新分发

## 状态键枚举，避免魔法字符串
enum StateKey {
	IDLE,
	MOVE,
	DASH,
	ATTACK,
	SKILL,
	HIT,
	DEATH
}

## 状态切换信号
signal state_changed(new_state: State)

## 初始状态
@export var initial_state_key: StateKey = StateKey.IDLE

## 当前状态
var current_state: State

## 状态字典
var states: Dictionary = {}

## 状态历史栈
var state_history: Array[State] = []
@export var max_history_size: int = 3

func _ready() -> void:
	# 收集所有静态子状态节点
	for child in get_children():
		if child is State:
			# 根据节点名推断 StateKey
			var key = _get_state_key_from_node_name(child.name)
			if key != -1:
				register_state(child, key)
	
	# 设置初始状态
	if states.has(initial_state_key):
		current_state = states[initial_state_key]
		current_state.enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func register_state(state: State, key: StateKey) -> void:
	"""注册状态节点"""
	states[key] = state
	state.state_machine = self
	state.character = owner as CharacterController
	if state.character:
		state.anim_sprite = state.character.anim_sprite

func change_state(new_state_key: StateKey) -> bool:
	"""切换状态，返回是否成功"""
	if not states.has(new_state_key):
		push_error("State not found: " + str(new_state_key))
		return false
	
	var new_state = states[new_state_key]
	
	# 优先级检查
	if current_state and not current_state.can_interrupt_by(new_state):
		return false
	
	# 保存历史
	if current_state:
		state_history.push_front(current_state)
		if state_history.size() > max_history_size:
			state_history.pop_back()
		current_state.exit()
	
	# 切换状态
	current_state = new_state
	current_state.enter()
	
	state_changed.emit(current_state)
	return true

func revert_to_previous_state() -> bool:
	"""恢复到上一个状态"""
	if state_history.is_empty():
		return change_state(StateKey.IDLE)
	
	var previous_state = state_history.pop_front()
	if current_state:
		current_state.exit()
	
	current_state = previous_state
	current_state.enter()
	state_changed.emit(current_state)
	return true

func _get_state_key_from_node_name(node_name: String) -> int:
	"""根据节点名推断 StateKey"""
	match node_name:
		"IdleState":
			return StateKey.IDLE
		"MoveState":
			return StateKey.MOVE
		"DashState":
			return StateKey.DASH
		"AttackState":
			return StateKey.ATTACK
		"SkillState":
			return StateKey.SKILL
		"HitState":
			return StateKey.HIT
		"DeathState":
			return StateKey.DEATH
		_:
			push_warning("Unknown state node name: " + node_name)
			return -1
