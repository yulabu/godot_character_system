extends Node

## 测试脚本 - 验证状态机是否正常工作

@onready var player: CharacterController = get_node_or_null("../Player")
@onready var label: Label = $Label

func _ready() -> void:
	# 创建 UI 标签
	if not label:
		label = Label.new()
		label.name = "Label"
		label.position = Vector2(10, 10)
		label.add_theme_font_size_override("font_size", 16)
		add_child(label)
	
	print("=== 角色操作系统测试 ===")
	print("按键说明:")
	print("  WASD - 移动")
	print("  J - 攻击")
	print("  K - 技能")
	print("  L - 冲刺/闪避")
	print("========================")

func _process(delta: float) -> void:
	if not player or not player.state_machine:
		return
	
	var state_name = "未知"
	if player.state_machine.current_state:
		state_name = player.state_machine.current_state.name
	
	var direction = player.last_direction
	var velocity = player.velocity
	
	if label:
		label.text = """状态: %s
方向: %s
速度: %s
位置: %s

操作说明:
WASD - 移动
J - 攻击
K - 技能
L - 冲刺/闪避""" % [state_name, direction, velocity, player.position]
