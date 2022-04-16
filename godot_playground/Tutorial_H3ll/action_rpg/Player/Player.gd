extends KinematicBody2D

signal life_change (life_value)

const ACCELERATION = 500
const MAX_SPEED = 80
const ROLL_SPEED = 130
const FRICTION = 500
const MAX_LIFE = 5

enum { MOVE, ROLL, ATTACK }

var state = MOVE
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var roll_vector = Vector2.DOWN

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $AttackPivot/SwordHitBox
onready var hurtbox = $Hurtbox
onready var life = MAX_LIFE setget life_change

func _ready():
	set_vector_positions(roll_vector)
	animationTree.set_active(true)
	

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		MOVE: move_state(delta)
		ROLL: roll_state(delta)
		ATTACK: attack_state(delta)


func move_state(delta: float):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector == Vector2.ZERO:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if input_vector != Vector2.ZERO:
		set_animation_blend_pos(input_vector) 
		set_vector_positions(input_vector)
		
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	move()

	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	

func roll_state(_delta: float):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("roll")
	hurtbox.set_hurtbox_enable(false)
	move()


func attack_state(delta: float):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	animationState.travel("attack")
	move()


func life_change(value):
	emit_signal("life_change", value)
	life = value
	if(life <= 0):
		queue_free()


func move():
	velocity = move_and_slide(velocity)


func set_animation_blend_pos(vector: Vector2):
	animationTree.set("parameters/idle/blend_position", vector)
	animationTree.set("parameters/run/blend_position", vector)
	animationTree.set("parameters/attack/blend_position", vector)
	animationTree.set("parameters/roll/blend_position", vector)


func set_vector_positions(vector: Vector2):
	roll_vector = vector
	swordHitbox.POSITION = vector


func _on_AnimationPlayer_finishedAnimation(_anim):
	hurtbox.set_hurtbox_enable(true)
	state = MOVE


func _on_Hurtbox_area_entered(area):
	self.life -= area.DAMAGE
	knockback = area.POSITION * area.IMPACT
