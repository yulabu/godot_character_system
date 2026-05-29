extends CharacterController

## 测试模式 - 用颜色变化代替动画
## 当没有动画素材时，用颜色区分状态

@onready var test_sprite: ColorRect = $TestSprite

var state_colors = {
	"IdleState": Color.WHITE,
	"MoveState": Color.GREEN,
	"DashState": Color.YELLOW,
	"AttackState": Color.RED,
	"SkillState": Color.CYAN,
	"HitState": Color.MAGENTA,
	"DeathState": Color.DARK_GRAY
}

func _ready() -> void:
	# 创建测试用的彩色方块
	if not test_sprite:
		test_sprite = ColorRect.new()
		test_sprite.name = "TestSprite"
		test_sprite.size = Vector2(32, 32)
		test_sprite.position = Vector2(-16, -16)
		add_child(test_sprite)
	
	# 连接状态切换信号
	if state_machine:
		state_machine.state_changed.connect(_on_state_changed)

func _on_state_changed(new_state: State) -> void:
	"""状态切换时改变颜色"""
	if test_sprite and new_state:
		var color = state_colors.get(new_state.name, Color.WHITE)
		test_sprite.color = color
		print("状态切换: ", new_state.name)

func play_animation(anim_name: String) -> void:
	"""测试模式下不播放动画，只打印信息"""
	# 忽略动画播放
	pass
