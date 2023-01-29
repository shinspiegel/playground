extends MonsterBase

@onready var shoot_spawn: MonsterShootSpawner = $MonsterShootSpawner

var is_shooting_started: bool = false

func apply_special(_delta: float) -> void:
	if not is_shooting_started:
		is_shooting_started = true
		shoot_spawn.shoot()
