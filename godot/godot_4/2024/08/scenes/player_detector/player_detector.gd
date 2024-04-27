class_name PlayerDetector extends Area2D

@export var external_origin_point: Node2D
@export var excluded_list: Array[CollisionObject2D] = []

signal player_sighted()
signal player_lost()

var __player: Player
var __excluded: Array[RID] = [self]
var __signed_emited: bool = false


func _ready() -> void:
	body_entered.connect(on_body_enter)
	body_exited.connect(on_body_exit)
	for item in excluded_list:
		__excluded.append(item.get_rid())


func _physics_process(_delta: float) -> void:
	if __player == null:
		return

	var from_pos: Vector2 = global_position

	if external_origin_point:
		from_pos = external_origin_point.global_position

	var space = get_world_2d().direct_space_state
	var params = PhysicsRayQueryParameters2D.create(
		from_pos,
		__player.global_position,
		get_collision_mask(),
		__excluded
	)
	var line_of_sight_obstacle = space.intersect_ray(params)

	if line_of_sight_obstacle.has("collider") and line_of_sight_obstacle.collider == __player and not __signed_emited:
		player_sighted.emit()
		__signed_emited = true


func get_player() -> Player:
	return __player


func get_player_global_position():
	if not __player == null:
		return __player.global_position
	return null


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		__player = body


func on_body_exit(body: Node2D) -> void:
	if body is Player:
		__player = null
		__signed_emited = false
		player_lost.emit()
