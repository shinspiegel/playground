class_name Player extends CharacterBody2D

@export var anim: AnimationPlayer
@export var sprite: Sprite2D

var has_double_jump: bool = true

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_apply_jump()
	_apply_direction(Input.get_axis("ui_left", "ui_right"))
	_apply_flip(Input.get_axis("ui_left", "ui_right"))

	move_and_slide()

	_apply_animation()
	_reset_double_jump()


func hurt_player() -> void:
	queue_free()


func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GameManager.GRAVITY * delta


func _apply_jump() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = GameManager.JUMP_VELOCITY
		elif has_double_jump:
			velocity.y = GameManager.JUMP_VELOCITY
			has_double_jump = false


func _apply_direction(dir: float) -> void:
	if dir:
		var ratio = 1.0
		if not is_on_floor(): ratio = 0.7
		if not is_on_floor() and not has_double_jump: ratio = 1.2

		velocity.x = (dir * GameManager.SPEED) * ratio
	else:
		velocity.x = move_toward(velocity.x, 0, GameManager.SPEED)


func _apply_flip(dir: float) -> void:
	if dir > 0: sprite.flip_h = false
	if dir < 0: sprite.flip_h = true


func _apply_animation() -> void:
	if abs(velocity.x) == 0:
		anim.play("idle")

	if abs(velocity.x) > 0:
		anim.play("move")

	if velocity.y < 0:
		anim.play("jump_up")

	if velocity.y > 0:
		anim.play("jump_down")


func _reset_double_jump() -> void:
	if is_on_floor():
		has_double_jump = true
