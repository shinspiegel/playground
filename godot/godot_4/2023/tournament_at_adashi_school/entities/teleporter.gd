class_name Teleporter extends Area2D

@export var room_name: String
@export_range(0, 10, 1) var position_index: int = 0


func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		RoomManager.change_to_room(room_name, position_index)
