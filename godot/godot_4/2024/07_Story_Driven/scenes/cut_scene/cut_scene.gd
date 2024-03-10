class_name CutScene extends Node2D

@export var data: CutSceneData
@export var scene_actors: Array[Actor] = []

@export_group("Initial Pos", "initial_")
@export_range(0.1, 2.0, 0.1) var initial_duration: float = 0.3
@export var initial_position: Array[Node2D] = []

@export_group("Camera", "camera_")
@export var camera_current: Camera2D
@export var camera_pos: Node2D
@export_range(0.1, 2.0, 0.1) var camera_duration: float = 0.3


func _ready() -> void:
	if data == null: push_error("missing data for cutscene")


func start():
	GameManager.change_to_cut_scene()

	if camera_pos and camera_current:
		var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
		PartyManager.disabled_leader_camera()
		tw.tween_property(camera_current, "global_position", camera_pos.global_position, camera_duration)
		tw.play()
		await tw.finished

	if initial_position.size() > 0:
		var tw = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)

		for index in range(initial_position.size()):
			if index < PartyManager.party_size():
				PartyManager.at(index).play_move(PartyManager.at(index).last_dir)
				tw.tween_property(PartyManager.at(index), "global_position", initial_position[index].global_position, initial_duration)

		tw.play()
		await tw.finished

	CutSceneManager.start(data, scene_actors)
	await CutSceneManager.ended
	GameManager.change_to_world()

