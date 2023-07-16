extends Node3D

@onready var label: Label = $CanvasLayer/Control/Label


func _ready() -> void:
	SignalBus.player_state_change.connect(on_state_changed)

func on_state_changed(state: String) -> void:
	label.text = """DEBUG::
PlayerState::[%s]
""" % state
