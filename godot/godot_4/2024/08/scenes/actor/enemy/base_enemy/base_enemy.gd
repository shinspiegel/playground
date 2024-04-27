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


func on_receive_damage(dmg: Damage) -> void:
	GameManager.spawn_damage_number(dmg, damage_position.global_position)
	receive_damage(dmg.amount)
	state_machine.change_state(hit_state.name)


func receive_damage(val: int) -> void:
	hp = clampi(hp - val, 0, max_hp)
