class_name LevelSegment extends Node2D

signal player_entered()

@onready var respawn_point: Node2D = %RespawnPoint
@onready var entry_detection: Area2D = %EntryDetection
@onready var top_left: Node2D = %TopLeft
@onready var bottom_right: Node2D = %BottomRight
@onready var update_nodes: Node2D = %UpdateNode


func _ready() -> void:
	entry_detection.body_entered.connect(on_body_enter)


func is_enabled() -> bool:
	return not update_nodes.process_mode == Node.PROCESS_MODE_DISABLED


func enable() -> void:
	update_nodes.process_mode = Node.PROCESS_MODE_INHERIT


func disable() -> void:
	update_nodes.process_mode = Node.PROCESS_MODE_DISABLED


## Screen limits in array
## 0: Top (y)
## 1: Left (x)
## 2: Bottom (y)
## 3: Right (x)
func get_limit_list() -> Array[int]:
	return [
		top_left.global_position.y,
		top_left.global_position.x,
		bottom_right.global_position.y,
		bottom_right.global_position.x,
	]


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		player_entered.emit()

