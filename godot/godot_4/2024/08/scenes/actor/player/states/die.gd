extends PlayerState

@export var anim_player: AnimationPlayer


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(DIE)
	player.velocity = Vector2.ZERO
	player.dmg_receiver.active = false


func update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == DIE:
		GameManager.player.died.emit()


