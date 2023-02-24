class_name CharacterEntity extends Resource

@export var max_hp: int = 10
@export var hp: int = 0
@export var speed: int = 0


func _init() -> void:
	hp = max_hp
