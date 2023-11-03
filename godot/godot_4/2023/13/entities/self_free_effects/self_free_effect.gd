class_name SelfFreeEffect extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(on_finish)


func on_finish(_name: String) -> void:
	queue_free()


func set_direction(dir: float) -> void:
	if dir < 0:
		scale.x *= -1
