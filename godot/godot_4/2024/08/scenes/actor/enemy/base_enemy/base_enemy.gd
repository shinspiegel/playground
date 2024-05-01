class_name BaseEnemy extends BaseActor

@export var max_hp: int = 10
@export var hp: int = 10
@export var direction: int = -1
@export var hit_state: EnemyState
@export var death_state: EnemyState
@export var touch_inflictor: DamageInflictor

@onready var damage_receiver: DamageReceiver = $FlipEnabled/DamageReceiver


func _ready() -> void:
	reset_hp()
	state_machine.change_initial()
	state_machine.state_changed.connect(on_state_change)


func _physics_process(delta: float) -> void:
	state_machine.update(delta)


func reset_hp() -> void:
	hp = max_hp


func is_on_hit() -> bool:
	return state_machine.is_on_state(hit_state)


func is_on_death() -> bool:
	return state_machine.is_on_state(death_state)


func turn_to(target_position: Vector2) -> void:
	direction = clampi(int((target_position - global_position).x), -1, 1)


func receive_damage(val: int) -> void:
	hp = clampi(hp - val, 0, max_hp)


func on_receive_damage(dmg: Damage) -> void:
	if not is_on_hit() or is_on_death():
		GameManager.spawn_damage_number(dmg, damage_position.global_position)
		receive_damage(dmg.amount)
		state_machine.change_by_state(hit_state)


func on_state_change(state: String) -> void:
	if state == death_state.name:
		touch_inflictor.active = false
