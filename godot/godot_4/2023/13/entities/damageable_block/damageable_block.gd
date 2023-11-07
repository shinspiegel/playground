class_name DamageableBlock extends Node2D

@export var health: Health
@export var damage_receiver: DamageReceiver


func _ready() -> void:
	if damage_receiver:
		damage_receiver.receive_damage.connect(on_receive_damage)
	
	if health:
		health.zeroed.connect(on_die)


func on_receive_damage(damage: Damage) -> void:
	health.deal_damage(damage)


func on_die() -> void:
	queue_free()
