extends KinematicBody2D

export (int) var ACCELERATION = 150
export (int) var MAX_SPEED = 30
export (float) var FRICTION = 0.1
export (int) var GRAVITY = 400
export (int) var JUMP_FORCE = 160
export (int) var MAX_HITPOINTS = 1
export (String, "Left", "Right") var initialSide := "Left" 
export (PackedScene) var bombScene

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var hurtBox: Hurtbox = $Hurtbox
onready var hitBox: Hitbox = $Hitbox
onready var frontFloor: RayCast2D = $Senses/FrontFloor
onready var rearFloor: RayCast2D = $Senses/RearFloor
onready var bombColdown: Timer = $BombColdown
onready var bombPosition: Position2D = $Senses/BombSpawnPosition

enum { IDLE, ATTACK, HIT, DEATH }

var life = MAX_HITPOINTS
var state = IDLE
var motion = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO
var flip_direction: int = 1
var player: Player = null

func _ready() -> void:
	if initialSide == "Left":
		apply_flip_scale(Vector2.LEFT)


func _physics_process(delta: float) -> void:
	var input_vector = direction
	
	if life <= 0:
		_change_state(DEATH)
	
	match state:
		IDLE: _state_idle(input_vector, delta)
		ATTACK: _state_attack(input_vector, delta)
		HIT: _state_hit(input_vector, delta)
		DEATH: _state_death()


func _state_attack(input: Vector2, delta: float):
	bombColdown.start()
	animationPlayer.play("Attack")
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_idle(input: Vector2, delta: float):
	animationPlayer.play("Idle")
	input = Vector2.ZERO
	
	if bombColdown.time_left == 0 and player != null:
		_change_state(ATTACK)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_death():
	animationPlayer.play("Death")
	
	hurtBox.disable()
	hitBox.deactive()
	motion = Vector2.ZERO


func _state_hit(input: Vector2, delta: float):
	animationPlayer.play("Hit")
	hitBox.deactive()
	
	input.x = (flip_direction * -1)
	
	if is_grounded():
		motion.y = -JUMP_FORCE / 2
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	move()


func _change_state(new_state):
	state = new_state


func is_grounded() -> bool:
	if frontFloor.is_colliding() or rearFloor.is_colliding():
		return true
	return false


func apply_gravity(delta: float):
	if not is_grounded():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE)


func apply_friction(input: Vector2, scale: float = 1.0):
	if input.x == 0 and is_grounded():
		motion.x = lerp(motion.x, 0, (FRICTION * scale))


func apply_horizontal_force(input: Vector2, delta: float):
	if input.x != 0:
		motion.x += input.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)


func apply_flip_scale(input: Vector2):
	var value = input.x
	
	if value != 0:
		if value > 0 and flip_direction == -1:
			scale.x *= -1
			flip_direction = 1
		if value < 0 and flip_direction == 1:
			scale.x *= -1
			flip_direction = -1


func change_life(value):
	life += value


func spawn_bomb():
	var instance = bombScene.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = bombPosition.global_position
	
	var space = get_world_2d().direct_space_state
	space.intersect_ray(global_position, player.global_position, [self])
	var distance_to_player = player.global_position.distance_to(global_position)
	
	instance.linear_velocity.x = distance_to_player * 0.8
	instance.linear_velocity.x *= flip_direction


func move():
	motion = move_and_slide(motion, Vector2.UP)


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Hit":
			hitBox.active()
			
			if life > 0:
				_change_state(IDLE)
			else: 
				_change_state(DEATH)
		
		"Attack":
			_change_state(IDLE)
		
		"Death":
			queue_free()


func _on_Hurtbox_hit(damage):
	if not state == HIT:
		change_life(-damage)
		_change_state(HIT)


func _on_PlayerSense_body_entered(body: Node) -> void:
	if body is Player and bombColdown.time_left == 0:
		player = body
		_change_state(ATTACK)


func _on_PlayerSense_body_exited(body: Node) -> void:
	if body is Player:
		player = null
		_change_state(IDLE)


func _on_BackSense_body_entered(body: Node) -> void:
	if body is Player:
		var direction = Vector2.ZERO
		direction.x = flip_direction * -1
		apply_flip_scale(direction)
