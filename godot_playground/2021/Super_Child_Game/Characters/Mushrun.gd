extends Character

export(String, "Idle", "Run", "Hit", "Chase") var State := "Run"

onready var idleTimer = $IdleTimer
onready var playerChaseTimer = $PlayerChaseTimer
onready var floorFront: RayCast2D = $Senses/FloorFront
onready var wallFront: RayCast2D = $Senses/WallFront
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
		
		"Chase":
			update_animation("Run", 2.0)
			
			input.x = flip_direction
			speed_scale.x = 2.0
			
			if wallFront.is_colliding():
				speed_scale.x = 1.0
				State = "Run"
			
			if playerChaseTimer.time_left <= 0:
				speed_scale.x = 1.0
				State = "Idle"

		"Hit":
			update_animation("Hit")

	apply_all(input, delta)
	apply_move(speed_scale)


func take_damage(damage: int) -> void:
	HIT_POINTS -= damage
	State = "Hit"


func die() -> void:
	queue_free()
	Utils.create_instante_from_packed_scene(deathAnimation, global_position)


func _on_PlayerDetection_body_entered(body: Player) -> void:
	if not body is Player: 
		return
	
	if not State == "Chase":
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, body.global_position, [self])
		 
		if result.collider is Player: 
			playerChaseTimer.start()
			State = "Chase"


func animation_finished(animation: String) -> void:
	if animation == "Hit":
		check_death()
		State = "Idle"
