extends Control

@onready var start: Button = %Start
@onready var quit: Button = %Quit


func _ready() -> void:
	start.pressed.connect(func(): SceneManager.change_to(SceneManager.LEVELS.world_map))
	quit.pressed.connect(func(): get_tree().quit())
	start.grab_focus()
