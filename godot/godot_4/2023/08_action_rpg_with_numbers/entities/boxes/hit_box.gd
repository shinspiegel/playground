class_name HitBox extends Area3D

signal hit(box: HurtBox)

@export var damage: Damage


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area3D) -> void:
	if area is HurtBox:
		area.deal_damage(damage)
		hit.emit(area)
