extends Node2D

onready var label: Label = $Position2D/Label
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	var con = animation_player.connect("animation_finished", self, "on_complete")
	if not con == OK:
		print_debug("INFO:: Failed to connect hurt [%s]" % [animation_player.name])
	animation_player.play("animate")


func set_text(text: String) -> void:
	label.text = text


## OVERRIDE CLASS METHODS

## SIGNAL METHODS


func on_complete(_animation_name: String) -> void:
	queue_free()

## SETUP METHODS
