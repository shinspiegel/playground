class_name CutSceneStartArea extends Area2D

@export var replay: bool = false
@export var cut_scene: CutScene

var enabled: bool = true


func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if enabled and node is PlayerActor and node.is_user_controlled:
		cut_scene.start()

		if not replay:
			enabled = false

