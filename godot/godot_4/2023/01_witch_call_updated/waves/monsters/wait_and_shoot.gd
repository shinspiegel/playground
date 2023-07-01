extends MonsterBase

@onready var shoot_spawn: MonsterShootSpawner = $MonsterShootSpawner


func apply_special(_delta: float) -> void:
	shoot_spawn.shoot()
