extends Character

export(String, "Idle", "Run", "Hit") var State := "Run"

onready var idleTimer = $Timers/IdleTimer
onready var floorFront: RayCast2D = $Senses/FloorFront
onready var wallFront: RayCast2D = $Senses/WallFront
onready var playerDetection: Area2D = $Senses/PlayerDetection
onready var deathAnimation = preload("res://Effects/DeathAnimation.tscn")

func _physics_process(delta: float) -> void:
	var input := Vector2.ZERO
	var speed_scale := Vector2.ONE 

	match State:
		"Idle":
			update_animation("Idle")
			
			if idleTimer.time_left <= 0:
				input.x = flip_direction
				input.x *= -1
				State = "Run"

		"Run":
			update_animation("Run")
			
			input.x = flip_direction
			
			if wallFront.is_colliding():
				input.x = flip_direction
				input.x *= -1

			if not floorFront.is_colliding():
				State = "Idle"
				idleTimer.start()
				input.x = 0
			
		"Attack":
			update_animation("Attack")
			motion.x = 0
			
		"Hit":
			update_animation("Hit")
			motion.x = 0

	apply_all(input, delta)
	apply_move()

func take_damage(damage: int) -> void:
	HIT_POINTS -= damage
	State = "Hit"


func die() -> void:
	queue_free()
	Utils.create_instante_from_packed_scene(deathAnimation, global_position)


func _on_PlayerDetection_body_entered(body: Player) -> void:
	if not body is Player: 
		return
	
	if not State == "Attack":
		playerDetection.set_monitoring(false)
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, body.global_position, [self])
		 
		if result.collider is Player: 
			State = "Attack"


func animation_finished(animation: String) -> void:
	if animation == "Hit":
		State = "Idle"
		check_death()
	
	if animation == "Attack":
		State = "Idle"
		playerDetection.set_monitoring(true)
