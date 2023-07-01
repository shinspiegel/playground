class_name WorldGame extends Node2D


func _ready() -> void:
	RoomManager.switched_room_to.connect(update_room)
	RoomManager.change_to_room("room_1", 0)


func update_room(room: BaseRoom) -> void:
	remove_all_children()
	call_deferred("add_child", room)


func remove_all_children() -> void:
	for child in get_children():
		child.queue_free()
