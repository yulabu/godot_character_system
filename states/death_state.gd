extends State

## 死亡状态

@export var priority: int = 100

func enter() -> void:
	character.velocity = Vector2.ZERO
	character.play_animation("death")

func can_interrupt_by(new_state: State) -> bool:
	# 死亡状态不可被打断
	return false
