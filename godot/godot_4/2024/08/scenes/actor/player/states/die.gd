extends PlayerState

@export var anim_player: AnimationPlayer


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(DIE)
	actor.velocity = Vector2.ZERO
	actor.dmg_receiver.active = false


func update(delta: float) -> void:
	actor.apply_gravity(delta)
	actor.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == DIE:
		GameManager.player_died.emit()


