extends Node2D

signal screen_changed(size: Vector2i)

@export var screen_size: Vector2i = Vector2i.ZERO


func _ready() -> void:
	get_tree().get_root().size_changed.connect(on_resize)
	screen_size = get_tree().get_root().size


func on_resize() -> void:
	screen_size = get_window().size
	screen_changed.emit(screen_size)
