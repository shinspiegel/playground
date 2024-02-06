class_name PlayerArea extends Node2D

@export var ground_floor: CollisionShape2D
@export var left_wall: CollisionShape2D
@export var right_wall: CollisionShape2D


func _ready() -> void:
	GameManager.screen_changed.connect(on_screen_change)



func on_screen_change(size: Vector2i) -> void:
	_update_ground(size)
	_update_left(size)
	_update_right(size)


func _update_ground(size: Vector2i) -> void:
	var shape = ground_floor.shape
	if shape is RectangleShape2D:
		shape.size.x = size.x
		ground_floor.position.y = size.y - (shape.size.y / 2)
		ground_floor.position.x = size.x / float(2)


func _update_left(size: Vector2i) -> void:
	var shape = left_wall.shape
	if shape is RectangleShape2D:
		shape.size.y = size.y
		left_wall.position.x = 0
		left_wall.position.y = size.y / float(2)


func _update_right(size: Vector2i) -> void:
	var shape = right_wall.shape
	if shape is RectangleShape2D:
		shape.size.y = size.y
		right_wall.position.x = size.x
		right_wall.position.y = size.y / float(2)

