extends CardBase

@export_range(0, 10, 1) var damage: int = 1


func activate(owner: CharacterEntity, target: CharacterEntity) -> void:
	target.deal_damage(damage)
	
