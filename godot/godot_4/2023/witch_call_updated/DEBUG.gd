class_name DEBUG extends CanvasLayer

@export var run_data: RunData 

@onready var level: Label = $Control/VBoxContainer/Label
@onready var wave: Label = $Control/VBoxContainer/Wave

func _ready() -> void:
	SignalBus.level_changed_to.connect(on_level_change)
	SignalBus.update_wave_debug_name.connect(on_wave_name_change)
	on_level_change(run_data.level)


func on_level_change(current_level: int) -> void:
	level.text = "LEVEL: [%s]" % [current_level-1]


func on_wave_name_change(wave_name: String) -> void:
	wave.text = wave_name.rsplit("/", true, 1)[1]
