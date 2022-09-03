extends Node2D

@onready var label: Label = $Label

func _ready() -> void:
	SignalBus.state_entered_for.connect(state_entered)


func state_entered(target: Node2D, state: String) -> void:
	if target is Player:
		label.text = "STATE: " + state
