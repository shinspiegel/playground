extends InteractableObject

@export_group("Loot Options")
@export var possible_loot: Array[PossibleLoot]
@export_range(1.0, 10.0, 0.1) var extra_push: float = 3.0


func _on_interact() -> void:
	for loot_entry in possible_loot:
		if randf_range(0.0, 1.0) < loot_entry.chance:
			var clone = loot_entry.loot.duplicate()
			
			if clone is InventoryItem: 
				clone.rand_direction()
				clone.rand_spawn_force(extra_push)
			
			GameManager.spawn_item(clone, global_position)
	
	queue_free()
