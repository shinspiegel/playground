class_name EndFlag extends Area3D

@export var next_scene: String

func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node3D) -> void:
	if body is Player: 
		GameManager.level_manager.load_level(next_scene)
