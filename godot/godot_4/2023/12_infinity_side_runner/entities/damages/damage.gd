class_name Damage extends Resource

@export var amount: int = 10

@export_group("Randomized", "rand_")
@export var rand_min: int = 10
@export var rand_max: int = 20

func rand_amount() -> void:
	amount = randi_range(rand_min, rand_max)
