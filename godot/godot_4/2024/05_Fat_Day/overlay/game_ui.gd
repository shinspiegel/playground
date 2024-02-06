class_name GameUI extends Control

@export var score_label: Label


func _ready() -> void:
	GameManager.donuts_changed.connect(on_donuts_change)
	on_donuts_change()


func on_donuts_change() -> void:
	score_label.text = "Score %s" % [GameManager.donuts_eaten]

