extends CanvasLayer

@onready var texture_progress_bar: TextureProgressBar = $Control/Control/TextureProgressBar

func _ready() -> void:
	PlayerData.health_changed.connect(update_health_bar)
	update_health_bar()


func update_health_bar() -> void:
	texture_progress_bar.max_value = PlayerData.max_health
	texture_progress_bar.value = PlayerData.health
