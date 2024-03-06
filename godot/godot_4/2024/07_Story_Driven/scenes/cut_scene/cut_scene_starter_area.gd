class_name CutSceneStartArea extends Area2D

@export var replay: bool = false
@export var steps: Array[CutSceneStepBase] = []
@export var scene_actors: Array[Actor] = []

var enabled: bool = true

func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if enabled and node is PlayerActor and node.is_user_controlled:
		GameManager.change_to_cut_scene()
		CutSceneManager.start(steps, scene_actors)
		await CutSceneManager.ended
		GameManager.change_to_world()

		if not replay:
			enabled = false

