extends Resource
class_name PlayerStats

signal health_changed(current, maximum)

export(int) var max_value = 10

var current_value = max_value


func _init() -> void:
	emit_signal("health_changed", current_value, max_value)


func reset():
	heal(max_value)


func take_damage(amount):
	current_value = max(0, current_value - amount)
	emit_signal("health_changed", current_value, max_value)


func heal(amount):
	current_value = min(max_value, current_value + amount)
	emit_signal("health_changed", current_value, max_value)
