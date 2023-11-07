extends Node2D

@export var health: Health
@onready var progress_bar: ProgressBar = $ProgressBar


func _ready() -> void:
	if health:
		health.changed.connect(on_health_change)
		progress_bar.value = health.get_current_value()
		progress_bar.max_value = health.get_max_value()


func on_health_change(value: int, max_value: int) -> void:
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", value, 0.5)
	tween.tween_property(progress_bar, "max_value", max_value, 0.2)
