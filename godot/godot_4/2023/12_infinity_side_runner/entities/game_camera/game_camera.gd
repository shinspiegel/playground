class_name GameCamera extends Camera2D

@export var fade_time: float = 5.0

var __randomizer = RandomNumberGenerator.new()
var __current_strenght: float = 0.0


func _ready() -> void:
	GameManager.shake_created.connect(on_shake)


func _process(delta: float) -> void:
	if __current_strenght > 0.0:
		__current_strenght = lerpf(__current_strenght, 0, fade_time * delta)
		offset = __random_offset()


func on_shake(value: float = 50.0) -> void:
	__current_strenght = value


func __random_offset() -> Vector2:
	return Vector2(__randomizer.randf_range(-__current_strenght, __current_strenght), __randomizer.randf_range(-__current_strenght, __current_strenght))