class_name Player extends CharacterBody2D

const MULTIPLIER = 100.0
const SPEED = 10.0 * MULTIPLIER
const JUMP_VELOCITY = 20.0 * MULTIPLIER
const GRAVITY = 60 * MULTIPLIER
const ACCELERATION = 0.2

@export var camera: Camera2D
@export var state_machine: StateMachine
@export var inputs: PlayerInputs
@export var coyote_timer: Timer
@export var camera_holder: RemoteTransform2D
@export var damage_receiver: DamageReceiver
@export var damage_coldown: Timer

var __facing: int = 1
var __airborne: bool = false


func _ready() -> void:
	if camera: camera_holder.set_remote_node(camera.get_path())
	if damage_receiver: damage_receiver.receive_damage.connect(on_receive_damage)


func _process(_delta: float) -> void:
	__flip()


func _physics_process(_delta: float) -> void:
	__start_coyote_timer()


func apply_gravity(delta: float, ratio: float = 1.0) -> void:
	velocity.y += GRAVITY * delta * ratio


func is_horizontal_zero() -> bool:
	return velocity.x == 0.0


func apply_horizontal_force(direction: float, friction: float = 1.0, ratio: float = 1.0) -> void:
	velocity.x = lerp(velocity.x, direction * SPEED * friction * ratio, ACCELERATION)
	velocity.x = clamp(velocity.x, -SPEED, SPEED)


func is_on_floor_coyote() -> bool:
	if not is_on_floor() and coyote_timer.is_stopped():
		return false
	return true


func on_receive_damage(damage: Damage) -> void:
	if damage_coldown.is_stopped():
		damage_coldown.start()
		state_machine.change_to("hurt")
		__apply_damage(damage)


## Private Methods


func __flip() -> void:
	if inputs.last_direction != 0:
		if inputs.last_direction > 0 and __facing == -1:
			scale.x *= -1
			__facing = 1
		if inputs.last_direction < 0 and __facing == 1:
			scale.x *= -1
			__facing = -1


func __start_coyote_timer() -> void:
	if is_on_floor():
		__airborne = false
		coyote_timer.stop()
	elif not __airborne:
		__airborne = true
		coyote_timer.start()


func __apply_damage(damage: Damage) -> void:
	var horizontal_dir = clampf(global_position.x - damage.source_position.x, -1, 1)
	var vertical_dir = clampf(damage.source_position.y - global_position.y, -1, 1)
	
	velocity.x = horizontal_dir * SPEED * (damage.impact * MULTIPLIER)
	velocity.y = -(vertical_dir * SPEED * (damage.impact / 10.0))
