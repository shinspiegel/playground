extends Area2D
class_name Hurtbox

signal hit(damage)

onready var timer: Timer = $InvenciblityTimer
onready var collisor: CollisionShape2D = $Collisor

func disable():
	collisor.set_disabled(true)


func _on_Hurtbox_area_entered(hitbox: Hitbox):
	if (hitbox is Hitbox) and timer.time_left == 0.0:
		collisor.set_disabled(true)
		timer.start()
		emit_signal("hit", hitbox.damage)


func _on_InvenciblityTimer_timeout():
	collisor.set_disabled(false)
	
	if get_overlapping_areas().size() > 0:
		for area in get_overlapping_areas():
			_on_Hurtbox_area_entered(area)
