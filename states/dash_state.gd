extends State

## 冲刺/闪避状态

@export var priority: int = 20
@export var dash_duration: float = 0.3

var dash_timer: float = 0.0
var dash_direction: Vector2

func enter() -> void:
	dash_timer = dash_duration
	dash_direction = character.velocity.normalized()
	if dash_direction == Vector2.ZERO:
		dash_direction = Vector2.DOWN
	character.play_animation("dash")

func physics_update(delta: float) -> void:
	dash_timer -= delta
	character.velocity = dash_direction * character.dash_speed
	character.move_and_slide()
	
	# 闪避判定（调用角色接口）
	if character.check_dodge():
		# 无敌帧处理
		pass
	
	if dash_timer <= 0:
		state_machine.change_state(StateMachine.StateKey.IDLE)

func exit() -> void:
	character.velocity = Vector2.ZERO
