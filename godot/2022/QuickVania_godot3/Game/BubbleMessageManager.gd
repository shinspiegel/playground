class_name BubbleMessagManager extends Node

var bubble_scene = load("res://Entities/MessageBubble/MessageBubble.tscn")


func display_message_at(
	message: String, position: Vector2, voice: String = "male_voice", volume: float = 0.0, pitch: float = 1.0
) -> MessageBubble:
	return display(message, false, position, voice, volume, pitch)


func displa_wait_message_at(
	message: String, position: Vector2, voice: String = "male_voice", volume: float = 0.0, pitch: float = 1.0
) -> MessageBubble:
	return display(message, true, position, voice, volume, pitch)


func display(message: String, wait: bool, position: Vector2, voice: String, volume: float, pitch: float) -> MessageBubble:
	var bubble = bubble_scene.instance()

	Manager.level.add_child(bubble)

	bubble.speak(message, wait, volume, voice, pitch)
	bubble.global_position = position

	return bubble
