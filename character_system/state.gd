class_name State extends Node

## 状态基类，所有状态继承此类

## 状态优先级，数字越大优先级越高
@export var priority: int = 0

## 引用（由状态机注入）
var character: CharacterController
var anim_sprite: AnimatedSprite2D
var state_machine: StateMachine

func enter() -> void:
	"""进入状态时调用"""
	pass

func exit() -> void:
	"""退出状态时调用"""
	pass

func update(delta: float) -> void:
	"""每帧更新（逻辑）"""
	pass

func physics_update(delta: float) -> void:
	"""物理帧更新（移动、碰撞）"""
	pass

func can_interrupt_by(new_state: State) -> bool:
	"""是否可被新状态打断"""
	return new_state.priority > priority

func connect_animation_finished(callback: Callable) -> void:
	"""安全连接动画结束信号"""
	if anim_sprite and not anim_sprite.animation_finished.is_connected(callback):
		anim_sprite.animation_finished.connect(callback)

func disconnect_animation_finished(callback: Callable) -> void:
	"""安全断开动画结束信号"""
	if anim_sprite and anim_sprite.animation_finished.is_connected(callback):
		anim_sprite.animation_finished.disconnect(callback)
