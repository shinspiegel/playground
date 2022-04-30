extends Area2D
class_name HitBox

export(int) var damage = 1

func _on_HitBox_area_entered(hurtBox: HurtBox) -> void:
	if not hurtBox is HurtBox:
		return
	
	hurtBox.emit_signal("hit", damage)
