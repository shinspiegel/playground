extends Area2D
class_name HitBox

export(int) var damage = 1

func _on_Hitbox_area_entered(hurtbox: HurtBox) -> void:
	if not hurtbox is HurtBox:
		return
	
	hurtbox.emit_signal("hit", damage)
