extends Area2D
class_name Collectable

export(String) var type = ""
export(PackedScene) var CollectEffect = null


func _on_Collectable_body_entered(body: Node) -> void:
	if not body is Player: 
		return
	
	body.collect_item(type)
	
	if CollectEffect != null:
		Utils.instance_scene_on_main(CollectEffect, global_position)
	
	queue_free()
