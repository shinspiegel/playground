extends EnemyState

@export var idle_duration: Timer
@export var next_state: EnemyState


func _ready() -> void:
	idle_duration.timeout.connect(on_idle_end)


func enter() -> void:
	play_anim()
	idle_duration.start()


func on_idle_end() -> void:
	state_machine.change_state(next_state.name)

