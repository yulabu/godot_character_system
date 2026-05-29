extends State

## 移动状态

@export var priority: int = 10

func enter() -> void:
	character.play_animation("run")

func physics_update(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector.length() > 0.1:
		character.update_direction(input_vector)
		character.velocity = input_vector.normalized() * character.move_speed
		character.play_animation("run")
	else:
		character.velocity = Vector2.ZERO
		state_machine.change_state(StateMachine.StateKey.IDLE)
	
	character.move_and_slide()
