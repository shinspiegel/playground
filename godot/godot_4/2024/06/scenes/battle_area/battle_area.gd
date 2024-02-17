class_name BattleArea extends Area2D

const MOVE_DURATION = 0.3

@export var player_actor_pos: Array[Node2D] = []
@export var camera_position: Node2D
@export var game_camera: Camera2D


func _ready() -> void:
	if player_actor_pos.size() < 3: push_error("invalid position for player actors, needs to have 3 position")
	if not camera_position: push_error("missing camera position node")
	if not game_camera: push_error("missing game camera node")

	body_entered.connect(on_body_enter)


func on_body_enter(body: Node) -> void:
	if body is PlayerActor and body.is_user_controlled:
		__prepare_battle()


func __prepare_battle() -> void:
	GameManager.change_to_cut_scene()

	var tw = create_tween().set_ease(Tween.EASE_OUT).set_parallel(true)

	for index in PartyManager.party_size():
		var party_member: PlayerActor = PartyManager.at(index)
		party_member.play_move(party_member.last_dir)
		var party_pos: Node2D = player_actor_pos[index]
		tw.tween_property(party_member, "global_position", party_pos.global_position, MOVE_DURATION)

	tw.play()
	await tw.finished

	for member in PartyManager.party:
		member.disable_camera()
		member.play_animation("idle", member.global_position.direction_to(camera_position.global_position).normalized().angle())

	tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(game_camera, "global_position", camera_position.global_position, MOVE_DURATION)
	tw.play()
	await tw.finished

	BattleManager.start_battle(PartyManager.party, __get_enemy_targets())


func __get_enemy_targets() -> Array[EnemyActor]:
	var actor_nodes: Array[EnemyActor] = []

	for node in get_overlapping_bodies():
		if node is EnemyActor:
			actor_nodes.append(node)

	return actor_nodes


