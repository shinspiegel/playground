extends PlayerState

@export var anim_player: AnimationPlayer
@export var die_sound: AudioStream


func enter() -> void:
	player.change_animation(DIE)
	player.velocity = Vector2.ZERO
	player.dmg_receiver.active = false
	anim_player.animation_finished.connect(on_anim_finished)
	AudioManager.create_sfx(die_sound)


func exit() -> void:
	anim_player.animation_finished.disconnect(on_anim_finished)


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()


func on_anim_finished(_anim: String) -> void:
	GameManager.player.died.emit()


