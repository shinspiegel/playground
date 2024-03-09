class_name CutSceneStartArea extends Area2D

@export var replay: bool = false
@export var initial_pos: Array[Node2D] = []
@export var steps: Array[CutSceneStepBase] = []
@export var scene_actors: Array[Actor] = []

var enabled: bool = true


func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if enabled and node is PlayerActor and node.is_user_controlled:
		GameManager.change_to_cut_scene()

		# Animated
		if initial_pos.size() > 0:
			var tw = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)

			for index in range(initial_pos.size()):
				if index < PartyManager.party_size():
					PartyManager.party[index].play_move(PartyManager.party[index].last_dir)
					tw.tween_property(PartyManager.party[index], "global_position", initial_pos[index].global_position, 0.3)

			tw.play()
			await tw.finished

		# Starting
		CutSceneManager.start(steps, scene_actors)
		await CutSceneManager.ended
		GameManager.change_to_world()

		if not replay:
			enabled = false

