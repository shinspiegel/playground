extends Actor

onready var frontRay: RayCast2D = $FrontRay
onready var groudRay: RayCast2D = $GroudRay
onready var runCooldown: Timer = $RunCooldown
onready var vision: Area2D = $Vision

var player: Actor = null

func _ready() -> void:
	vision.connect("body_entered", self, "_on_Vision_body_entered")
	runCooldown.connect("timeout", self, "_on_timer_out")
	input.x = 1


func calculate_ground_speed() -> float:
	if runCooldown.is_stopped():
		return lerp(motion.x, input.x * SPEED, ACCELERATION)
	else:
		return lerp(motion.x, input.x * (SPEED * 8), ACCELERATION)


func _set_input():
	if not runCooldown.is_stopped():
		input.x = check_run_direction()
		return 
	
	if frontRay.is_colliding() or not groudRay.is_colliding():
		input.x *= -1
		return


func check_run_direction()->int:
	if player:
		var distance = player.global_position.x - global_position.x
		var run_direction = clamp(distance * -1, -1, 1)
		return run_direction
	else:
		return 0


func _on_timer_out():
	vision.set_monitoring(true)
	player = null


func _on_Vision_body_entered(body: Node) -> void:
	if runCooldown.is_stopped() and body is Actor and body.name == "Player":
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, body.global_position, [self])
		
		if result.collider is Actor and result.collider.name == "Player":
			vision.set_monitoring(false)
			player = result.collider
			runCooldown.start()
