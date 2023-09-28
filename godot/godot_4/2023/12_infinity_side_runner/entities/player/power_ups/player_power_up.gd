class_name PlayerPowerUp extends Resource

signal selection_change(state:bool)

@export var power_up: String
@export_multiline var description: String
@export var cost: int
@export var is_selected: bool


func change_selection(state: bool) -> void:
	is_selected = state
	selection_change.emit(state)
