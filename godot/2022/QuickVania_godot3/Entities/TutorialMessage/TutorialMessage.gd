extends Area2D

onready var label: Label = $Position2D/Label
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	label.visible = false

	var con
	con = connect("body_entered", self, "on_body_entered")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])

	con = connect("body_exited", self, "on_body_exited")
	if not con == OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


## OVERRIDE CLASS METHODS

## SIGNAL METHODS


func on_body_entered(body: Node) -> void:
	if body is Player:
		animation_player.play("Fade_in")


func on_body_exited(body: Node) -> void:
	if body is Player:
		animation_player.play("Fade_out")

## SETUP METHODS
