class_name Effect extends Node2D

@export var audio_sfx: AudioStream
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(on_anim_finished)
	AudioManager.play_sfx(audio_sfx)


func on_anim_finished(_anim: String) -> void:
	queue_free()
