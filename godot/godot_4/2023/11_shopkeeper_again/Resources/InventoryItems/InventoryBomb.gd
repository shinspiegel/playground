class_name InventoryBomb extends InventoryItem

@export_group("Explosive", "explosive_")
@export_range(0.0, 5.0, 0.1) var explosive_time: float
@export_range(1.0, 10.0, 0.1) var explosive_area: float = 2
@export var explosive_damage: Damage


func get_type() -> String: 
	return "%s Bomb" % [__get_rarity_name()]


func get_description() -> String:
	return """This is a bomb.
Explodes after %ss seconds in a area of %s.
%s
""" % [
	explosive_time, explosive_area,
	explosive_damage.get_description()
]
