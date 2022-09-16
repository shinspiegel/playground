extends Node

func instance_scene_on_main(scene: PackedScene, position: Vector2):
	var main = get_tree().current_scene
	var instance = scene.instance()
	
	main.add_child(instance)
	instance.global_position = position
	
	return instance
