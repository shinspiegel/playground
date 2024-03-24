class_name LevelMap extends Node2D

@export var sorted: Node2D
@export var pos: Node2D
@export var game_camera: Camera2D


func _ready() -> void:
	if not sorted: push_error("failed to locate the sorted node")
	if not pos: push_error("failed to locate the initial player position node")
	if not game_camera: push_error("missing game camera node")

	AudioManager.play_music(AudioManager.Musics.WORLD)
	StoryManager.story_changed.connect(on_story_change)
	spawn_party()
	on_story_change(StoryManager.data)


func on_story_change(_story: StoryData) -> void:
	push_warning("story changed and this map didn't updated")


func spawn_party() -> void:
	for index in PartyManager.party_size():
		var player: PlayerActor = PartyManager.at(index)
		player.global_position = pos.global_position
		player.camera = game_camera

		if index == 0:
			player.is_user_controlled = true
		else:
			player.follow_side = 1 if index % 1 == 0 else -1

		sorted.add_child(player)

