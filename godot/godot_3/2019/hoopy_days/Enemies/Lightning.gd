extends Node2D

func _process(delta):
	position.y += 800 * delta



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.has_method("hurt"):
		body.hurt()
	queue_free()