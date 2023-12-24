extends Node2D

@export var enemy: BaseEnemy
@export var state_machine: StateMachine
@export var health: Health
@export var zero_health_state: BaseEnemyState


func _ready() -> void:
	health.zeroed.connect(on_health_zeroed)


func on_health_zeroed() -> void:
	state_machine.change_to(zero_health_state.name)
