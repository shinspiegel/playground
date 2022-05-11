class_name LevelManager extends Node2D

export(PackedScene) var firstScene

var currentScene


func _ready() -> void:
	if not firstScene == null:
		var scene = firstScene.instance()
		get_tree().current_scene.add_child(scene)
		currentScene = scene
