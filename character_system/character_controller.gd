class_name CharacterController extends CharacterBody2D

## 角色控制器，持有角色数据和组件引用

## 角色属性
@export var move_speed: float = 200.0
@export var dash_speed: float = 400.0
@export var dash_cost: float = 20.0

## 组件引用
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

## 方向
var last_direction: String = "down"

func _ready() -> void:
	# 确保状态机已初始化
	if not state_machine:
		push_error("StateMachine not found!")

func update_direction(input_vector: Vector2) -> void:
	"""更新角色朝向"""
	var abs_x = abs(input_vector.x)
	var abs_y = abs(input_vector.y)
	
	if abs_x > abs_y:
		last_direction = "right" if input_vector.x > 0 else "left"
	else:
		last_direction = "down" if input_vector.y > 0 else "up"

func play_animation(anim_name: String) -> void:
	"""播放动画（自动加方向后缀）"""
	if anim_sprite:
		anim_sprite.play(anim_name + "_" + last_direction)

func check_dodge() -> bool:
	"""闪避判定接口，返回true表示成功闪避"""
	# TODO: 实现闪避判定逻辑
	return true
