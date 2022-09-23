class_name GameInterface extends CanvasLayer

@onready var hp_label: Label = $MarginContainer/VBoxContainer/HP
@onready var state_label: Label = $MarginContainer/VBoxContainer/State

var curr_state := "NONE"
var curr_hp := 99
var curr_max := 99


func _ready() -> void:
	SignalBus.state_entered_for.connect(state_entered)
	SignalBus.player_hp_changed.connect(player_hp_changed)
	update_label()


func player_hp_changed(val, max_hp) -> void:
	curr_hp = val
	curr_max = max_hp
	update_label()


func state_entered(target: Node2D, state: String) -> void:
	if target is Player:
		curr_state = state
		update_label()


func update_label() -> void:
	hp_label.text = "[%s/%s]" % [curr_hp, curr_max]
	state_label.text = "STATE: %s" % [curr_state]
