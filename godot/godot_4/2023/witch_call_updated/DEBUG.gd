class_name DEBUG extends CanvasLayer

@export var run_data: RunData 

@onready var level: Label = $Control/VBoxContainer/Label

func _ready() -> void:
	SignalBus.level_changed_to.connect(on_level_change)
	on_level_change(run_data.level)


func on_level_change(current_level: int) -> void:
	level.text = "LEVEL: [%s]" % [current_level-1]
