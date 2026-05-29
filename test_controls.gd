extends Node

## 测试脚本 - 验证状态机是否正常工作
## 可以删除此文件

func _ready() -> void:
	print("=== 角色操作系统测试 ===")
	print("按键说明:")
	print("  WASD - 移动")
	print("  J - 攻击")
	print("  K - 技能")
	print("  L - 冲刺/闪避")
	print("========================")

func _process(delta: float) -> void:
	# 显示当前状态
	var player = get_node_or_null("../Player")
	if player and player.state_machine:
		var state_name = ""
		if player.state_machine.current_state:
			state_name = player.state_machine.current_state.name
		# 可以在这里显示状态到 UI
