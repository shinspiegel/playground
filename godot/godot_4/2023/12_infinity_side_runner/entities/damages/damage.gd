class_name Damage extends Resource

@export var amount: int = 10
@export var shake: float = 20.0

@export_group("Randomized", "rand_amount_")
@export var rand_amount_min: int = 10
@export var rand_amount_max: int = 20


func rand_amount() -> void:
	amount = randi_range(rand_amount_min, rand_amount_max)
