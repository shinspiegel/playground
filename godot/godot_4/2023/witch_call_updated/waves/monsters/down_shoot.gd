extends MonsterBase

@onready var shoot_spawn: MonsterShootSpawner = $MonsterShootSpawner


func apply_special(delta: float) -> void:
	apply_movement(delta)
	shoot_spawn.shoot()
