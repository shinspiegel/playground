class_name IntCounter extends Resource

signal changed_value(current)
signal reached_max
signal reached_min
signal changed_detailed(current, minimum, maximum)

export(int) var max_value = 10
export(int) var min_value = 0
export(int) var current = 0


func _init() -> void:
	emit_signal("changed_value", current)


func set_value(value: int) -> void:
	if value > max_value:
		value = max_value

	if value < min_value:
		value = min_value

	current = value
	emit_signals()


func update_value(amount: int) -> void:
	if amount < 0:
		current = max(min_value, current + amount)

	if amount > 0:
		current = min(max_value, current + amount)

	emit_signals()


func set_to_min() -> void:
	set_value(min_value)


func set_to_max() -> void:
	set_value(max_value)


func reduce(amount: int = 1) -> void:
	update_value(-amount)


func increase(amount: int = 1) -> void:
	update_value(amount)


func emit_signals() -> void:
	emit_signal("changed_value", current)
	emit_signal("changed_detailed", current, min_value, max_value)

	if current == max_value:
		emit_signal("reached_max")

	if current == min_value:
		emit_signal("reached_min")
