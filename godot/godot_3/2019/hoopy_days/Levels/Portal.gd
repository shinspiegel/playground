extends Node2D

export (PackedScene) var NextLevel

func _on_Area2D_body_entered(body):
	get_tree().change_scene_to(NextLevel)
