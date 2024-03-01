class_name WeaponEquipament extends Equipment

@export_range(2, 20, 2) var damage_dice: int = 2


func rand() -> int:
	return randi_range(2, damage_dice)
