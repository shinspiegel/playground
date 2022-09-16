extends Area2D
class_name HurtBox

# warning-ignore:unused_signal
signal hit(damage)
onready var invencibleTimer: Timer = $InvenvibleTimer
onready var hurtArea: CollisionShape2D = $HurtArea


func start_invencibility_time():
	hurtArea.set_disabled(true)
	invencibleTimer.start()


func _on_Timer_timeout() -> void:
	hurtArea.set_disabled(false)
	if get_overlapping_areas().size() > 0:
		for area in get_overlapping_areas():
			_on_Hurtbox_area_entered(area)


func _on_Hurtbox_area_entered(hitbox: Area2D) -> void:
	if not hitbox is HitBox:
		return
	
	if invencibleTimer.time_left == 0:
		start_invencibility_time()
		emit_signal("hit", hitbox.damage)
