extends State

## 技能状态

@export var priority: int = 30

var skill_finished: bool = false

func enter() -> void:
	skill_finished = false
	character.velocity = Vector2.ZERO
	character.play_animation("skill")
	connect_animation_finished(_on_animation_finished)

func exit() -> void:
	disconnect_animation_finished(_on_animation_finished)

func _on_animation_finished() -> void:
	skill_finished = true
	state_machine.change_state(StateMachine.StateKey.IDLE)
