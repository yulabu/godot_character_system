extends State

## 待机状态

@export var priority: int = 0

func enter() -> void:
	character.velocity = Vector2.ZERO
	character.play_animation("idle")

func physics_update(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector.length() > 0.1:
		character.update_direction(input_vector)
		state_machine.change_state(StateMachine.StateKey.MOVE)
