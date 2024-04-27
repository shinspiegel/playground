class_name DamageInflictor extends Area2D

@export var dmg_generator: DamageGenerator
@export var active: bool = true

var __areas_map: Dictionary = {}


func _ready() -> void:
	area_entered.connect(on_area_enter)
	area_exited.connect(on_area_exit)


func _physics_process(_delta: float) -> void:
	if active:
		for area: DamageReceiver in __areas_map.values():
			if area.can_hit():
				area.hit(dmg_generator.generate(global_position))


func on_area_enter(area: Area2D) -> void:
	if area is DamageReceiver:
		__areas_map[area.name] = area


func on_area_exit(area: Area2D) -> void:
	__areas_map.erase(area.name)
