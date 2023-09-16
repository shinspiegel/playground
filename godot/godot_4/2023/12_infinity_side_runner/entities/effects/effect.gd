class_name Effect extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(on_anim_finished)


func on_anim_finished(_anim: String) -> void:
	queue_free()
