class_name LevelSegment extends Node2D

signal player_entered()

@export var parallax_offset: Vector2 = Vector2.ZERO

@onready var respawn_point: Node2D = %RespawnPoint
@onready var entry_detection: Area2D = %EntryDetection
@onready var top_left: Node2D = %TopLeft
@onready var bottom_right: Node2D = %BottomRight
@onready var back: Node2D = %Back
@onready var middle: Node2D = %Middle
@onready var front: Node2D = %Front


func _ready() -> void:
	entry_detection.body_entered.connect(on_body_enter)


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

