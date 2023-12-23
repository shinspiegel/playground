class_name EnemyInput extends BaseInputs

signal changed_direction()


func set_direction(dir: float) -> void:
	direction = dir

	if not dir == 0.0:
		last_direction = dir

	changed_direction.emit()
