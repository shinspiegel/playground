extends Node

func instance_scene_on_main(scene: PackedScene, position: Vector2):
	var root = get_tree().current_scene
	var instance = scene.instance()
	root.add_child(instance)
	instance.global_position = position
	return instance
