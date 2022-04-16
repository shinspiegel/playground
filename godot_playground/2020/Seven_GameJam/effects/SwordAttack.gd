extends Node2D

export(PackedScene) var SlashHitEffect
export(int) var variable_range := 4

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if not area is HurtBox:
		return
	
	var slashEffect = Utils.instance_scene_on_main(SlashHitEffect, area.global_position)
	slashEffect.position.x += rand_range(-variable_range, variable_range)
	slashEffect.position.y += rand_range(-variable_range, variable_range)
