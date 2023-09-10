class_name DamageableBlock extends StaticBody2D

@export var health_max: int = 5
var health_current: int = 5

@onready var damage_receiver: DamageReceiver = $DamageReceiver


func _destroy() -> void:
	print_debug("WARN::Not implemented, queue free")
	queue_free()


func _ready() -> void:
	damage_receiver.receive_damage.connect(on_receive_damage)
	health_current = health_max


func on_receive_damage(damage: Damage) -> void:
	GameManager.spawn_damage_number(damage, global_position)
	health_current = clampi(health_current - damage.amount, 0, health_max)
	
	if health_current == 0:
		_destroy()
