extends EnemyState

@export var idle_duration: Timer
@export var next_state: EnemyState


func _ready() -> void:
	idle_duration.timeout.connect(on_idle_end)


func enter() -> void:
	play_anim()
	idle_duration.start()


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_direction(0, enemy.data.friction_land, 0.9)
	enemy.move_and_slide()
	enemy.check_flip(enemy.direction)


func on_idle_end() -> void:
	state_machine.change_state(next_state.name)

