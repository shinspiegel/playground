extends Character
class_name Player

signal changed_collectables(collectable_dict)

var collectable_dict = {
	"coins": 0,
	"orbs": 0
}


func _ready() -> void:
	emit_signal("changed_collectables", collectable_dict)


func can_consume_orb():
	return collectable_dict.orbs > 0


func consume_obrs(value: int = 1):
	collectable_dict.orbs -= value
	emit_signal("changed_collectables", collectable_dict)


func collect_item(type: String):
	if type == "Coin":
		collectable_dict.coins += 1
	
	if type == "Orb":
		collectable_dict.orbs += 1
	
	if type == "Potion":
		heal_damage(1)
	
	emit_signal("changed_collectables", collectable_dict)
