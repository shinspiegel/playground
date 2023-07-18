class_name IntCounter extends Resource

@export var current: int = 0
@export var min_value: int = 0
@export var max_value: int = 10


func reset() -> void:
	current = max_value


func change(value: int) -> void:
	current = clampi(value + current, min_value, max_value)


func decrease(value: int = 1) -> void:
	change(-value)


func increase(value: int = 1) -> void:
	change(value)
