extends Node

signal level_changed()

const damage_number: Resource = preload("res://scenes/damageables/damage_number/damage_number.tscn")
const damage_text: Resource = preload("res://scenes/damageables/damage_number/damage_text.tscn")
const player_scene: Resource = preload("res://scenes/actor/player/player.tscn")

@export var game_setting: SavedData

var player: Player
var game_camera: GameCamera
var current_level: BaseLevel


func _ready() -> void:
	player = player_scene.instantiate()


func set_level(level: BaseLevel) -> void:
	current_level = level
	level_changed.emit()


func spawn_damage_number(damage: Damage, pos: Vector2 = Vector2.ZERO) -> void:
	var instance: DamageNumber = damage_number.instantiate()
	instance.damage = damage
	instance.global_position = pos
	instance = randomize_node_pos(instance)
	add_child_to_foreground(instance)


func spawn_damage_text(pos: Vector2 = Vector2.ZERO, text: String = "Blocked") -> void:
	var instance: DamageText = damage_text.instantiate()
	instance.text = text
	instance.global_position = pos
	instance = randomize_node_pos(instance)
	add_child_to_foreground(instance)


func randomize_node_pos(node: Node2D, pos_variation: Vector2 = Vector2(20,20)) -> Node2D:
	node.global_position.x += randf_range(-pos_variation.x, pos_variation.x)
	node.global_position.y += randf_range(-pos_variation.y, pos_variation.y)
	return node


func spawn_player(node: Node, pos: Vector2 = Vector2.ZERO, camera: GameCamera = null) -> void:
	node.add_child(player)
	player.global_position = pos

	if not camera == null:
		camera.global_position = pos
		camera.reset_smoothing()
		player.set_camera(camera)


func add_child_to_background(node: Node) -> void:
	current_level.add_to_background(node)


func add_child_to_foreground(node: Node) -> void:
	current_level.add_to_foreground(node)


func add_child_to_segment(node: Node) -> void:
	if current_level:
		var _name = current_level.name
		current_level.add_to_segment(node)
	else:
		push_error("current level unabailable")


func reload_current() -> void:
	player = player_scene.instantiate()
	player.stats = game_setting.saved_stats.duplicate(true)
	player.stats.reset_mp()
	get_tree().reload_current_scene()
