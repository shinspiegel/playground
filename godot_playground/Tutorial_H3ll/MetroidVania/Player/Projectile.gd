extends Node2D

class_name Projectile

var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	position += velocity * delta


func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport) -> void:
	queue_free()
