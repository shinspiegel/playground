class_name GameUI extends CanvasLayer

@onready var score: Label = $Control/MarginContainer/Label

var player_node: Player


func _ready() -> void:
	GameManager.score_changed.connect(on_score_change)
	on_score_change(GameManager.score)


func on_score_change(value: int) -> void:
	score.text = "Coins: %s" % [value]
