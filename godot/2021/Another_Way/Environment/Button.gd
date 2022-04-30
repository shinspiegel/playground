extends Area2D

signal pressed_in()
signal pressed_out()

onready var animationPlayer: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animationPlayer.play("idle")


func _on_DoorSense_body_entered(body: Node) -> void:
	animationPlayer.play("pushed")
	emit_signal("pressed_in")


func _on_DoorSense_body_exited(body: Node) -> void:
	if get_overlapping_bodies().size() < 1:
		animationPlayer.play("idle")
		emit_signal("pressed_out")
