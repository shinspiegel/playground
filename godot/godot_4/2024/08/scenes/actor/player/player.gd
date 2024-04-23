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
@onready var shoot_pos: Node2D = %ShotPosition
@onready var block_pos: Node2D = %BlockPosition
@onready var placements: Array[RayCast2D] = [%BlockTop, %BlockBottom]

var __is_coyoting: bool = false


func _ready() -> void:
	dmg_receiver.receive_damage.connect(on_damage_receive)


func _physics_process(delta: float) -> void:
	if not __is_coyoting and not is_on_floor():
		__is_coyoting = true
		coyote_timer.start()

	if is_on_floor() or jump_buffer_cast.is_colliding():
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
	if is_on_floor() or jump_buffer_cast.is_colliding() or coyote_timer.time_left > 0:
		return true
	return false


func can_roll() -> bool:
	if can_jump() and stats.can_use_mana():
		return true
	return false


func can_shoot() -> bool:
	if power_ups.ranged_enabled and can_jump() and stats.can_use_mana():
		return true
	return false


func can_create_block() -> bool:
	if power_ups.create_block_enabled and not placements[0].is_colliding() and not placements[1].is_colliding():
		return true
	return false


func can_dash() -> bool:
	if power_ups.forward_dash:
		return true
	return false


func on_damage_receive(dmg: Damage) -> void:
	GameManager.spawn_damage_number(dmg, damage_position.global_position)
	GameManager.game_camera.shake_damage(dmg)
	stats.deal_damage(dmg.amount)
	state_machine.change_state(PlayerState.HIT)

