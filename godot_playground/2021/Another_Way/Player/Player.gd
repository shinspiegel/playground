extends KinematicBody2D
class_name Player

signal life_changed(life, max_life)
signal mana_changed(mana)
signal coin_changed(coin)

export (int) var MAX_HITPOINTS = 5
export (int) var ACCELERATION = 600
export (int) var MAX_SPEED = 70
export (float) var FRICTION = 0.3
export (int) var GRAVITY = 400
export (int) var JUMP_FORCE = 160
export (int) var DASH_FORCE = 2400
export (PackedScene) var dustEffectScene
export (PackedScene) var dashEffectScene

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var dustEffectPosition: Position2D = $DustEffectPosition
onready var frontFloor: RayCast2D = $Senses/FrontFloor
onready var rearFloor: RayCast2D = $Senses/RearFloor
onready var topDashSense: RayCast2D = $Senses/TopDash
onready var bottomDashSense: RayCast2D = $Senses/BottomDash
onready var coyoteTimer: Timer = $Senses/CoyoteTimer
onready var dashTimer: Timer = $Senses/DashTimer
onready var dashTimerEffect: Timer = $Senses/DashTimerEffect
onready var stateList: Node2D = $StatesList

enum { MOVE, JUMP, FALLING, DASH, ATTACK, HIT, DEATH }

var life: int = MAX_HITPOINTS
var coins := 0
var mana := 0

var state = MOVE
var motion := Vector2.ZERO
var flip_direction: int = 1
var is_jumping := false
var is_double_jump := false
var is_dashing := false

func _ready():
	var player = LevelManager.get_player_data()
	
	if not player.life == null:
		life = player.life
	if not player.coins == null:
		coins = player.coins
	if not player.mana == null:
		mana = player.mana
	
	emit_signal("life_changed", life, MAX_HITPOINTS)
	emit_signal("mana_changed", mana)
	emit_signal("coin_changed", coins)


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	clean_state_flags()
	
	match state:
		MOVE: _state_move(input_vector, delta)
		JUMP: _state_jump(input_vector, delta)
		FALLING: _state_falling(input_vector, delta)
		ATTACK: _state_attack(input_vector, delta)
		DASH: _state_dash(input_vector, delta)
		HIT: _state_hit(input_vector, delta)
		DEATH: _state_death(input_vector)
	

func _input(event: InputEvent):
	if not state == HIT or not state == DEATH:
		if event.is_action_pressed("dash") and not is_dashing and not is_grounded():
			if not state == DASH and mana > 0:
				change_mana(-1)
				is_dashing = true
				_change_state(DASH)
		
		if event.is_action_pressed("jump") and not is_jumping:
			if state == FALLING and coyoteTimer.time_left > 0:
				is_jumping = true
				apply_jump()
				_change_state(JUMP)
			
			if not state == JUMP and not state == FALLING:
				is_jumping = true
				apply_jump()
				_change_state(JUMP)
			
			elif mana > 0 and not is_double_jump:
				is_double_jump = true
				apply_jump()
				change_mana(-1)
				_change_state(JUMP)
			
		if event.is_action_pressed("attack"):
			if not state == ATTACK and not state == DASH:
				_change_state(ATTACK)


# warning-ignore:unused_argument
func _state_death(input: Vector2):
	motion = Vector2.ZERO
	input = Vector2.ZERO
	animationPlayer.play("Death")


func _state_hit(input: Vector2, delta: float):
	animationPlayer.play("Hit")
	input.x = (flip_direction * -1)
	reset_jumping()
	
	if is_grounded():
		motion.y = -JUMP_FORCE / 2
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	move()


func _state_dash(input: Vector2, delta: float):
	animationPlayer.play("Dash")
	motion.y = 0
	
	if is_grounded() or is_front_sense_touching():
		_change_state(MOVE)
	
	create_dash_effect()
	apply_dash_force(delta)
	move()


func _state_attack(input: Vector2, delta: float):
	animationPlayer.play("Attack")
	input = Vector2.ZERO
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_falling(input: Vector2, delta: float):
	animationPlayer.play("Falling")
	
	if is_grounded():
		_change_state(MOVE)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_jump(input: Vector2, delta: float):
	animationPlayer.play("Jump")
	
	if motion.y > 0:
		_change_state(FALLING)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _state_move(input: Vector2, delta: float):
	if input == Vector2.ZERO:
		animationPlayer.play("Idle")
	
	if input != Vector2.ZERO:
		animationPlayer.play("Run")
	
	if motion.y > 0:
		_change_state(FALLING)
	
	apply_gravity(delta)
	apply_friction(input)
	apply_horizontal_force(input, delta)
	apply_flip_scale(input)
	move()


func _change_state(new_state):
	if new_state == state:
		return

	match new_state:
		FALLING:
			coyoteTimer.start()
		DASH:
			dashTimer.start()
	
	state = new_state


func is_grounded() -> bool:
	if frontFloor.is_colliding() or rearFloor.is_colliding():
		return true
	return false


func is_front_sense_touching() -> bool:
	if topDashSense.is_colliding() or bottomDashSense.is_colliding():
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


func apply_dash_force(delta: float):
	motion.x += flip_direction * DASH_FORCE * delta
	motion.x = clamp(motion.x, -MAX_SPEED * 3, MAX_SPEED * 3)


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
	
	if life > MAX_HITPOINTS:
		life = MAX_HITPOINTS
	
	emit_signal("life_changed", life, MAX_HITPOINTS)


func change_mana(value):
	mana += value
	emit_signal("mana_changed", mana)


func change_coin(value):
	coins += value
	emit_signal("coin_changed", coins)


func move():
	motion = move_and_slide(motion, Vector2.UP)


func apply_jump():
	create_dust_effect()
	motion.y = -JUMP_FORCE


func clean_state_flags():
	if life <= 0:
		_change_state(DEATH)
	
	if is_grounded():
		reset_jumping()


func reset_jumping():
	is_jumping = false
	is_double_jump = false
	is_dashing = false


func create_dust_effect():
	var instance = dustEffectScene.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = dustEffectPosition.global_position


func create_dash_effect():
	if dashTimerEffect.time_left == 0:
		dashTimerEffect.start()
		var instance = dashEffectScene.instance()
		get_tree().current_scene.add_child(instance)
		instance.scale.x *= flip_direction
		instance.global_position = dustEffectPosition.global_position


func _on_DashTimer_timeout() -> void:
	if not state == HIT or not state == DEATH:
		motion.x = 0
		_change_state(MOVE)


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Attack":
			_change_state(MOVE)
		
		"Hit":
			if life > 0:
				_change_state(MOVE)
			else: 
				_change_state(DEATH)
		
		"Death":
			queue_free()


func _on_Hurtbox_hit(damage):
	if not state == HIT:
		change_life(-damage)
		_change_state(HIT)


func _on_PickableRange_area_entered(pickable: Area2D):
	if pickable is Pickable:
		match pickable.type:
			"Potion":
				change_life(1)
				pickable.collect()
			"Mana":
				change_mana(1)
				pickable.collect()
			"Coin":
				change_coin(1)
				pickable.collect()
