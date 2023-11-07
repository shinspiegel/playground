class_name LevelUI extends CanvasLayer

@export var life_bar: Range


func _ready() -> void:
	GameManager.player_health_changed.connect(on_health_change)


func on_health_change(value: int, max_value: int) -> void:
	life_bar.value = value
	life_bar.max_value = max_value
