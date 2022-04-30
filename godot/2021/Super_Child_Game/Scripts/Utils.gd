extends Node

func create_instante_from_packed_scene(scene: PackedScene, position: Vector2):
	var instance = scene.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = position
	return instance
