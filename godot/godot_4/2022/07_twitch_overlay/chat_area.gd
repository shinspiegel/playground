class_name ChatArea extends Panel

@export var chat_message_scene: PackedScene

@onready var chat_list: VBoxContainer = $MarginContainer/ScrollContainer/ChatList


func add_message() -> void:
	var message = chat_message_scene.instantiate()
	chat_list.add_child(message)
	
	remove_extra_messages()


func remove_extra_messages() -> void:
	if chat_list.get_child_count() > 3:
		chat_list.get_children()[0].queue_free()
		remove_extra_messages()
