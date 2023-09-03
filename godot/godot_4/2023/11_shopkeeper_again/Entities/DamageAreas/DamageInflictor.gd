class_name DamageInflictor extends Area2D

@export var damage: Damage


func _ready() -> void:
	area_entered.connect(on_area_enter)


func on_area_enter(area: Area2D) -> void:
	if area is DamageReceiver:
		area.hit(damage.get_clone())