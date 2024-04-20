class_name Player extends BaseActor

@warning_ignore("unused_signal")
signal died()

@export var stats: PlayerStats
@export var power_ups: PowerUps

@onready var input: PlayerInput = %PlayerInput
@onready var dmg_receiver: DamageReceiver = %DamageReceiver
@onready var coyote_timer: Timer = %CoyoteTimer
@onready var jump_buffer_cast: RayCast2D = %JumpBufferRaycast2D
@onready var remote_camera: RemoteTransform2D = %RemoteCamera

var __is_coyoting: bool = false


func _ready() -> void:
	dmg_receiver.receive_damage.connect(on_damage_receive)


func _physics_process(delta: float) -> void:
	if not is_on_floor() and not __is_coyoting:
		coyote_timer.start()
		__is_coyoting = true

	if is_on_floor():
		coyote_timer.stop()
		__is_coyoting = false

	state_machine.update(delta)
	stats.tick_mp(delta)


func set_camera(camera: GameCamera) -> void:
	remote_camera.remote_path = camera.get_path()


func clean_camera() -> void:
	remote_camera.remote_path = ""


func should_fall() -> bool:
	if coyote_timer.time_left <= 0 and not is_on_floor():
		return true
	return false


func can_jump() -> bool:
	if jump_buffer_cast.is_colliding() or is_on_floor() or __is_coyoting:
		return true
	return false


func can_roll() -> bool:
	if can_jump() and stats.can_use_mana():
		return true
	return false


func on_damage_receive(dmg: Damage) -> void:
	stats.deal_damage(dmg.amount)
	GameManager.spawn_damage_number(dmg, damage_position.global_position)
	GameManager.game_camera.shake_damage(dmg)
	state_machine.change_state(PlayerState.HIT)

