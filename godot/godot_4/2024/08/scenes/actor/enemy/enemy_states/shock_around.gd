extends EnemyState

@export var shock_duration: Timer
@export var damage_inflictor: DamageInflictor


func enter() -> void:
	damage_inflictor.active = true
	shock_duration.timeout.connect(on_shock_end)
	shock_duration.start()
	enemy.velocity = Vector2.ZERO
	play_anim()


func exit() -> void:
	damage_inflictor.active = false
	shock_duration.timeout.disconnect(on_shock_end)


func update(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_direction(0, enemy.data.friction_land, 0.9)
	enemy.move_and_slide()
	enemy.check_flip(enemy.direction)


func on_shock_end() -> void:
	print("timeout")
	state_machine.change_initial()

