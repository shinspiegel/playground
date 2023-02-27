class_name CharacterEntity extends Resource

@export var max_hp: int = 10
@export var hp: int = 0
@export var speed: int = 0

@export var deck: Array[PackedScene] = []

var hand_size: int = 3

func reset() -> void:
	hp = max_hp


func has_lost() -> bool:
	if hp <= 0: 
		return true
	return false


func deal_damage(damage: int) -> void:
	hp -= damage
	if hp < 0:
		hp = 0


func heal_damage(healing: int) -> void:
	hp += healing
	if hp > max_hp:
		hp = max_hp

