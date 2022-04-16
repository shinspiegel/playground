extends Node

onready var score = get_node("VBoxContainer/Score")

func _ready() -> void:
	var save_data = SaveAndLoad.load_data_from_file()
	score.text = "Highscore : " + str(save_data.highscore)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/StartMenu.tscn")
