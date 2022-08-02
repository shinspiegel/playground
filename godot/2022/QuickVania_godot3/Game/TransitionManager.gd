class_name TransitionManager extends CanvasLayer

signal blacked
signal cleaned

onready var animation_player = $AnimationPlayer
onready var rect: ColorRect = $ColorRect


func _ready() -> void:
	rect.visible = false


func transition() -> void:
	rect.visible = true
	animation_player.play("Fade_in")
	yield(animation_player, "animation_finished")

	emit_signal("blacked")

	animation_player.play("Fade_out")
	yield(animation_player, "animation_finished")

	emit_signal("cleaned")
	rect.visible = false
