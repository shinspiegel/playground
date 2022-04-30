extends Character

class_name Player

export(String, "Idle", "Run", "Hit", "Jump") var State := "Idle"
export(int) var max_jumps := 2

onready var coyote_timer: Timer = $CoyoteTimer
onready var invincible_timer: Timer = $InvencibleTimer
onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
onready var hitBox: Area2D = $HitBox
onready var hurtBox: Area2D = $HurtBox
onready var jumpParticlePosition = $Positions/JumpParticlePosition

onready var jumpParticles = preload("res://Effects/JumpParticles.tscn")

var jumps: int = max_jumps

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	
	match State:
		"Idle":
			update_animation("Idle")
			input = get_input_axis()
			jumps = max_jumps
			
			if input.x != 0:
				State = "Run"
			
			if input.x != 0:
				State = "Jump"
			
			apply_all(input, delta)
			
		"Run":
			update_animation("Run")
			input = get_input_axis()
			jumps = max_jumps
			
			if input.x == 0:
				State = "Idle"
			
			if input.y != 0:
				State = "Jump"
			
			apply_all(input, delta)
			
		"Jump":
			update_animation("Jump")
			input = get_input_axis()
			
			if is_on_floor():
				if input.x != 0:
					State = "Run"
				
				if input.x == 0:
					State = "Idle"
					
			apply_all(input, delta)
			
		"Hit":
			update_animation("Hit")
			apply_all(input, delta)
			motion.x = 0
	
	update_hit_box()
	apply_move()


func take_damage(damage: int) -> void:
	motion.y = 0
	HIT_POINTS -= damage
	State = "Hit"
	invincible_timer.start()


func update_hurt_box(): 
	if invincible_timer.time_left > 0:
		hurtBox.set_monitoring(false)
	else:
		hurtBox.set_monitoring(true)


func update_hit_box():
	if not is_on_floor() and motion.y > 0:
		hitBox.set_monitoring(true)
	else:
		hitBox.set_monitoring(false)


func get_input_axis() -> Vector2:
	var input = Vector2.ZERO
	
	if Input.get_action_strength("ui_left") > 0:
		input.x -= Input.get_action_strength("ui_left")
	
	if Input.get_action_strength("ui_right") > 0:
		input.x = Input.get_action_strength("ui_right")
		
	if is_on_floor() or coyote_timer.time_left > 0:
		if Input.is_action_just_pressed("jump"):
			input.y = -1
	
	if not is_on_floor() and jumps > 0:
		if Input.is_action_just_pressed("jump"):
			Utils.create_instante_from_packed_scene(jumpParticles, jumpParticlePosition.global_position)
			jumps -= 1
			input.y = -0.75

	return input


func animation_finished(animation: String) -> void:
	if animation == "Hit":
		hurtBox.set_monitoring(true)
		check_death()
		State = "Idle"


func _on_HitBox_area_entered(hurtBox: HurtBox) -> void:
	if not hurtBox is HurtBox:
		return
	
	motion.y = -JUMP_FORCE
