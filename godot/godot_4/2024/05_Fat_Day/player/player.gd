extends CharacterBody2D

@export var anim: AnimationPlayer
@export var sprite: Sprite2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0
const GRAVITY = 1400
const ANIM = { "idle": "idle", "move": "move", "jump_up": "jump_up", "jump_down": "jump_down" }

var has_double_jump: bool = true

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_apply_jump()
	_apply_direction(Input.get_axis("ui_left", "ui_right"))
	_apply_flip(Input.get_axis("ui_left", "ui_right"))

	move_and_slide()

	_apply_animation()


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta


func _apply_jump() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if has_double_jump:
			velocity.y = JUMP_VELOCITY
			has_double_jump = false



func _apply_direction(dir: float) -> void:
	if dir:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func _apply_flip(dir: float) -> void:
	if dir > 0: sprite.flip_h = false
	if dir < 0: sprite.flip_h = true


func _apply_animation() -> void:
	if abs(velocity.x) == 0:
		anim.play(ANIM.idle)

	if abs(velocity.x) > 0: 
		anim.play(ANIM.move)
	
	if velocity.y < 0:
		anim.play(ANIM.jump_up)
	
	if velocity.y > 0:
		anim.play(ANIM.jump_down)

