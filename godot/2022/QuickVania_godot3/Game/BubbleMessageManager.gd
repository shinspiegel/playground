class_name BubbleMessagManager extends Node

var bubble_scene = load("res://Entities/MessageBubble/MessageBubble.tscn")


func display_message_at(message: String, position: Vector2, voice: String = "male_voice") -> void:
	var bubble = bubble_scene.instance()
	Manager.level.add_child(bubble)
	bubble.speak(message, 0.0, voice, 1)
	bubble.global_position = position
