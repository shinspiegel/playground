class_name CharacterEntity extends Resource

@export var max_hp: int = 10
@export var hp: int = 0
@export var speed: int = 0


func reset() -> void:
	hp = max_hp


func deal_damage(damage: int) -> void:
	hp -= damage
	if hp < 0:
		hp = 0
