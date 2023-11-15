extends BaseState

@export var enemy: BaseEnemy
@export var next_state: BaseState
@export var idle_colddown: Timer
@export var animation_player: AnimationPlayer


func _ready() -> void:
	idle_colddown.timeout.connect(on_time_out)


func enter() -> void:
	animation_player.play(name)
	idle_colddown.start()
	enemy.velocity = Vector2.ZERO


func on_time_out() -> void:
	state_ended.emit(next_state.name)
