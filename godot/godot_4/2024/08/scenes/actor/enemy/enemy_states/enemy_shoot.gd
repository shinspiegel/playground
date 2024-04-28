extends EnemyState

@export var anim_player: AnimationPlayer
@export var next_state: EnemyState


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	play_anim()


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.move_and_slide()


func on_anim_finished(anim: String) -> void:
	if anim == name:
		if not next_state == null:
			state_machine.change_by_state(next_state)
		else:
			state_machine.change_initial()





