extends CardBase

@export_range(0, 10, 1) var heal: int = 1


func activate(owner_entity: CharacterEntity, _target_entity: CharacterEntity) -> void:
	owner_entity.heal_damage(heal)
