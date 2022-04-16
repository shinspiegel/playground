extends StaticBody2D

export(PackedScene) var brokenEffect


# warning-ignore:unused_argument
func _on_Hurtbox_hit(damage: int) -> void:
	Utils.instance_scene_on_main(brokenEffect, global_position)
	queue_free()
