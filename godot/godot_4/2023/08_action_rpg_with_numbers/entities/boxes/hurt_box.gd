class_name HurtBox extends Area3D

signal hurt(damage: Damage)

@export var override_number_position: Node3D

func deal_damage(damage: Damage) -> void:
	hurt.emit(damage)
	spawn_number(damage)


func spawn_number(damage: Damage) -> void:
	var number: DamageNumber = Constants.DMG.NUMBER_SCENE.instantiate()
	get_tree().root.add_child(number)
	number.apply_damage(damage)
	
	if not override_number_position == null:
		number.global_position = override_number_position.global_position
	else:
		number.global_position = global_position
