class_name Player extends CharacterBody2D

@export var camera: Camera2D

@export_group("Heath")
@export var health: Health

@export_group("Extra Information")
@export var inputs: PlayerInputs
@export var sprite: OutlinedSprite2D

@export_group("Camera Details", "camera_")
@export var camera_holder: RemoteTransform2D
@export var camera_min_velocity: float = 100
@export var camera_max_distance: float = 600
@export_range(0.0, 1.0, 0.1) var camera_speed_weight: float = 0.5

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
var __interactable: Interactable = null


func _ready() -> void:
	if camera:
		camera_holder.set_remote_node(camera.get_path())

	if damage_receiver:
		damage_receiver.receive_damage.connect(on_receive_damage)

	if smoke_colddown and smoke_scene:
		smoke_colddown.timeout.connect(on_smoke_timeout)

	if sprite:
		sprite.enable()

	if health:
		health.changed.connect(on_player_health_change)
		health.reset()


func _process(_delta: float) -> void:
	__flip()


func _physics_process(delta: float) -> void:
	__start_coyote_timer()
	__update_camera_distance(delta)


func apply_gravity(delta: float, ratio: float = 1.0) -> void:
	velocity.y += Constants.GRAVITY * delta * ratio


func is_horizontal_zero() -> bool:
	return velocity.x == 0.0


func apply_horizontal_force(direction: float, friction: float = 1.0, ratio: float = 1.0) -> void:
	velocity.x = lerp(velocity.x, direction * Constants.SPEED * friction * ratio, Constants.ACCELERATION)
	velocity.x = clamp(velocity.x, -Constants.SPEED, Constants.SPEED)


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


func enable_outline() -> void:
	sprite.enable()


func disable_outline() -> void:
	sprite.disable()


func add_interactable(node: Interactable) -> void:
	__interactable = node


func clean_interactable() -> void:
	__interactable = null


func can_interact() -> bool:
	if not __interactable == null:
		return true
	return false


func act_on_interactable() -> void:
	if not __interactable == null:
		__interactable.interact()


## Signal Methods


func on_receive_damage(damage: Damage) -> void:
	if damage_coldown.is_stopped():
		damage_coldown.start()
		state_machine.change_to("hurt")
		__apply_damage(damage)


func on_smoke_timeout() -> void:
	GameManager.spawn_effect(smoke_scene, smoke_position.global_position, inputs.last_direction)


func on_player_health_change(curr: int, max_value: int) -> void:
	GameManager.player_health_changed.emit(curr, max_value)


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

	velocity.x = horizontal_dir * Constants.SPEED * (damage.impact * Constants.MULTIPLIER)
	velocity.y = -(vertical_dir * Constants.SPEED * (damage.impact / 10.0))


func __update_camera_distance(delta: float) -> void:
	if abs(velocity.x) > camera_min_velocity:
		var ratio =  abs(velocity.x) / Constants.SPEED
		var dist = ratio * camera_max_distance
		camera_holder.position.x = lerpf(camera_holder.position.x, dist * camera_max_distance * delta, camera_speed_weight / 100)
		camera_holder.position.x = clampf(camera_holder.position.x, 0, camera_max_distance)
	else:
		camera_holder.position.x = lerpf(camera_holder.position.x, 0, camera_speed_weight)
