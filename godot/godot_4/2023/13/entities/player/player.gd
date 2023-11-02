class_name Player extends CharacterBody2D

const MULTIPLIER = 100.0
const SPEED = 10.0 * MULTIPLIER
const JUMP_VELOCITY = 20.0 * MULTIPLIER
const GRAVITY = 60 * MULTIPLIER
const ACCELERATION = 0.2

@export var camera: Camera2D

@export_group("Extra Information")
@export var camera_holder: RemoteTransform2D
@export var inputs: PlayerInputs
@export var sprite: Sprite2D

@export_group("State Machine")
@export var state_machine: StateMachine

@export_group("Coyote Info", "coyote_")
@export var coyote_timer: Timer

@export_group("Damage Receiver", "damage_")
@export var damage_receiver: DamageReceiver
@export var damage_coldown: Timer

@export_group("Breathing Smoke Effect", "smoke_")
@export var smoke_scene: PackedScene
@export var smoke_colddown: Timer
@export var smoke_position: Node2D

var __facing: int = 1
var __airborne: bool = false
var __is_hide_enabled: bool = false
var __is_hidden: bool = false
var __duration: float = 0.2


func _ready() -> void:
	if camera: camera_holder.set_remote_node(camera.get_path())
	if damage_receiver: damage_receiver.receive_damage.connect(on_receive_damage)
	if smoke_colddown and smoke_scene: smoke_colddown.timeout.connect(on_smoke_timeout)
	if sprite: __update_outline(1.0)


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


func get_current_state() -> BaseState:
	return state_machine.get_current_state()


func get_state_name() -> String:
	return state_machine.get_current_state().name.to_lower()


func set_hidden(value: bool) -> void: __is_hidden = value
func is_hidden() -> bool: return __is_hidden


func enable_hide() -> void: __is_hide_enabled = true
func disable_hide() -> void: __is_hide_enabled = false
func can_hide() -> bool: return __is_hide_enabled


func start_breathing() -> void: smoke_colddown.start()
func stop_breathing() -> void: smoke_colddown.stop()


func enable_outline() -> void: __tween_countour(0.0, 1.0)
func disable_outline() -> void: __tween_countour(1.0, 0.0)


func on_receive_damage(damage: Damage) -> void:
	if damage_coldown.is_stopped():
		damage_coldown.start()
		state_machine.change_to("hurt")
		__apply_damage(damage)


func on_smoke_timeout() -> void:
	#TODO: Create a singleton for adding scenes
	var smoke: SelfFreeEffect = smoke_scene.instantiate()
	get_tree().root.add_child(smoke)
	smoke.global_position = smoke_position.global_position
	smoke.set_direction(inputs.last_direction)
	smoke_colddown.start()
	

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


func __tween_countour(from: float, to: float) -> void:
	var tween = get_tree().create_tween();
	tween.tween_method(__update_outline, from, to, __duration);


func __update_outline(value: float) -> void:
	sprite.material.set_shader_parameter("line_thickness", value)
