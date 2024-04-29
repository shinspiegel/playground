class_name BaseEnemy extends BaseActor

@export var max_hp: int = 10
@export var hp: int = 10
@export var direction: int = -1
@export var hit_state: EnemyState
@export var death_state: EnemyState

@onready var damage_receiver: DamageReceiver = $FlipEnabled/DamageReceiver


func _ready() -> void:
	hp = max_hp
	state_machine.change_initial()


func _physics_process(delta: float) -> void:
	state_machine.update(delta)


func is_on_hit() -> bool:
	return state_machine.get_current_name() == hit_state.name


func is_on_death() -> bool:
	return state_machine.get_current_name() == death_state.name


func turn_to(target_position: Vector2) -> void:
	direction = clampi(int((target_position - global_position).x), -1, 1)


func receive_damage(val: int) -> void:
	hp = clampi(hp - val, 0, max_hp)


func on_receive_damage(dmg: Damage) -> void:
	GameManager.spawn_damage_number(dmg, damage_position.global_position)
	receive_damage(dmg.amount)
	state_machine.change_by_state(hit_state)
