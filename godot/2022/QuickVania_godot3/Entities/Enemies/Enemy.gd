class_name Enemy extends KinematicBody2D

const BLOCK_SIZE = 16

export(int) var hit_points: int = 1
export var flip_direction: int = 1
export var is_flip_active = true
export var velocity = Vector2.ZERO
export(float) var speed: float = BLOCK_SIZE * 10
export(float) var jump_velocity: float = 120
export(float) var gravity: float = 300

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hurt_box: HurtBox = $HurtBox
onready var state_manager: StateManager = $StateManager
onready var message_pos: Position2D = $MessagePos


func _ready() -> void:
	setup_hurt_box()


func _physics_process(delta: float) -> void:
	state_manager.apply(delta)
	check_change_state()

	if Input.is_action_pressed(KeysMap.CANCEL):
		print("hurt monster")
		hurt(1)

	apply_flip_scale()
	velocity = move_and_slide(velocity, Vector2.UP)


func change_animation(anim: String) -> void:
	if not animation_player == null and animation_player.has_animation(anim):
		animation_player.play(anim)


func apply_flip_scale():
	if is_flip_active:
		var value = velocity.x

		if value != 0:
			if value > 0 and flip_direction == -1:
				scale.x *= -1
				flip_direction = 1
			if value < 0 and flip_direction == 1:
				scale.x *= -1
				flip_direction = -1


func apply_horizontal(diretion: float = 0.0, ratio: float = 1.0) -> void:
	if not diretion == 0.0:
		velocity.x = diretion * (speed * ratio)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * ratio)
		print(move_toward(velocity.x, 0, speed * ratio))


func apply_jump(amount = null) -> void:
	if amount == null:
		amount = jump_velocity

	velocity.y = (amount * -1)


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func speak(message: String) -> void:
	Manager.bubble.display_message_at(message, message_pos.global_position)


func check_change_state() -> void:
	pass


func hurt(damage: int = 1) -> void:
	hit_points -= damage

	if hit_points <= 0:
		state_manager.change_state("Die")


## OVERRIDE CLASS METHODS

## SIGNAL METHODS


func on_receive_hit(hit_box: HitBox) -> void:
	state_manager.change_state("Hit")
	state_manager.send_message("damage_hit_box", hit_box)


## SETUP METHODS


func setup_hurt_box() -> void:
	var con = hurt_box.connect("hit_received", self, "on_receive_hit")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [hurt_box.name])
