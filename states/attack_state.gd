extends State

## 攻击状态

@export var priority: int = 30

var attack_finished: bool = false

func enter() -> void:
	attack_finished = false
	character.velocity = Vector2.ZERO
	character.play_animation("attack")
	connect_animation_finished(_on_animation_finished)

func exit() -> void:
	disconnect_animation_finished(_on_animation_finished)

func physics_update(delta: float) -> void:
	# 检测连击输入（在攻击动画窗口期内）
	if Input.is_action_just_pressed("attack"):
		# 可以在这里处理连击逻辑
		pass

func _on_animation_finished() -> void:
	attack_finished = true
	state_machine.change_state(StateMachine.StateKey.IDLE)
