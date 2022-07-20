class_name BubbleMessagManager extends Node

var bubble_scene = load("res://Entities/MessageBubble/MessageBubble.tscn")


func display_message_at(message: String, position: Vector2) -> void:
	var bubble = bubble_scene.instance()
	Manager.level.add_child(bubble)
	bubble.set_text(message)
	bubble.global_position = position
