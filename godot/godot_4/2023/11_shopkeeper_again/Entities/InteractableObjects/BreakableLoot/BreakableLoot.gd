extends InteractableObject

@export_group("Loot Options")
@export var possible_loot: Array[PossibleLoot]


func _on_interact() -> void:
	for loot in possible_loot:
		if randf_range(0.0, 1.0) < loot.chance:
			var clone = loot.item.duplicate()
			
			if clone is InventoryItem: 
				clone.rand_direction()
				clone.rand_spawn_force()
			
			GameManager.spawn_item(clone, global_position)
	
	queue_free()
