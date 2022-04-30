extends Node2D

export(PackedScene) var EffectScene

func create_effect():
	var effect = EffectScene.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position

func _on_Hurtbox_area_entered(_area):
	create_effect()
	queue_free()
