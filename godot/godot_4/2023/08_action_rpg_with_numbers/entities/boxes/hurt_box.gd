class_name HurtBox extends Area3D

signal hurted(damage: Weapon)


func deal_damage(damage: Weapon) -> void:
	hurted.emit(damage)	
	
	