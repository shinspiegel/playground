extends Control

onready var startScreen = $Start
onready var optionScreen = $Options
onready var quitScreen = $Quit


func _ready() -> void:
	startScreen.visible = true
	quitScreen.visible = false
	optionScreen.visible = false
