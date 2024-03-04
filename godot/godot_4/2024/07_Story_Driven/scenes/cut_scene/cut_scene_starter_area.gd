class_name CutSceneStartArea extends Area2D

@export var steps: Array[CutSceneStep] = []

func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if node is PlayerActor and node.is_user_controlled:
		GameManager.change_to_cut_scene()
		CutSceneManager.start(steps)
		await CutSceneManager.ended
		GameManager.change_to_world()

