extends State

## 受击状态

@export var priority: int = 50
@export var interruptible: bool = false  # 可配置是否可被打断

var hit_finished: bool = false

func enter() -> void:
	hit_finished = false
	character.velocity = Vector2.ZERO
	character.play_animation("hit")
	connect_animation_finished(_on_animation_finished)

func exit() -> void:
	disconnect_animation_finished(_on_animation_finished)

func can_interrupt_by(new_state: State) -> bool:
	if interruptible:
		return new_state.priority > priority
	return false

func _on_animation_finished() -> void:
	hit_finished = true
	# 恢复到之前的状态，而不是固定回到 IDLE
	state_machine.revert_to_previous_state()
