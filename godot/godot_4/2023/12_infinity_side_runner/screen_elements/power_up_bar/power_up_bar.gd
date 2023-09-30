extends Control

@onready var current_label: Label = $TextureRect2/CurrentLabel
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar


func _ready() -> void:
	PlayerData.power_point_changed.connect(on_power_change)
	current_label.text = str(PlayerData.power_points)
	texture_progress_bar.value = PlayerData.power_points
	texture_progress_bar.max_value = PlayerData.max_power_points


func on_power_change(current_value: int, max_value: int) -> void:
	current_label.text = str(current_value)
	texture_progress_bar.value = current_value
	texture_progress_bar.max_value = max_value
