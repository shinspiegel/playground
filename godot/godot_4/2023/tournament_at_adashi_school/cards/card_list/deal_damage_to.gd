extends CardBase

@export_range(0, 10, 1) var damage: int = 1


func activate(_owner_entity: CharacterEntity, target_entity: CharacterEntity) -> void:
	target_entity.deal_damage(damage)
	
