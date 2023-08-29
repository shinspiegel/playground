extends InteractableObject

@export_group("Loot Options")
@export var possible_loot: Array[BreakableLootEntry]


func _on_interact() -> void:
	for loot in possible_loot:
		if randf_range(0.0, 1.0) < loot.chance:
			GameManager.spawn_item(loot.item, global_position)
	
	queue_free()
