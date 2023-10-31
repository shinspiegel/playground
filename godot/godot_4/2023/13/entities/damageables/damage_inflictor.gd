class_name DamageInflictor extends Area2D

@export var damage_generator: DamageGenerator = DamageGenerator.new()


func _ready() -> void:
	area_entered.connect(on_area_enter)


func on_area_enter(area: Area2D) -> void:
	if area is DamageReceiver:
		area.hit(damage_generator.random(global_position))
