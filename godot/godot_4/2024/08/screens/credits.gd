class_name CreditsScreen extends Control

@onready var back: Button = %Back


func _ready() -> void:
	AudioManager.play_music(0)
	back.pressed.connect(on_back)
	await get_tree().create_timer(0.5).timeout
	back.grab_focus()


func on_back() -> void:
	SceneManager.change_to_file(SceneManager.SCENES.start)
