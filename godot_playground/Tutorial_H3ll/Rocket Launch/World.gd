extends Node

onready var animation: AnimationPlayer = $AnimationPlayer


func _on_LaunchButton_pressed() -> void:
	animation.play("Launch")
