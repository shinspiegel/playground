extends PlayerState

@export_range(0.1, 2.0, 0.1) var duration: float = 2.0
@export var anim_player: AnimationPlayer
@export var die_sound: AudioStream

var __timer: SceneTreeTimer


func enter() -> void:
	player.change_animation(DIE)
	player.velocity = Vector2.ZERO
	player.dmg_receiver.active = false
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)
	AudioManager.create_sfx(die_sound)


func exit() -> void:
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()


func on_timeout() -> void:
	GameManager.player.died.emit()


