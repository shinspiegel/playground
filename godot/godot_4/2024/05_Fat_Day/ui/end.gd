extends CanvasLayer

@export var play_again_button: Button
@export var quit_button: Button
@export var grab_focus_timer: Timer
@export var score_label: Label


func _ready() -> void:
	GameManager.player_died.connect(on_player_die)
	quit_button.pressed.connect(func(): get_tree().quit())
	play_again_button.pressed.connect(on_play_again)
	grab_focus_timer.timeout.connect(func(): play_again_button.grab_focus())


func on_play_again() -> void:
	get_tree().reload_current_scene()


func display() -> void:
	show()
	score_label.text = "Score: %s" % [GameManager.donuts_eaten]
	grab_focus_timer.start()


func on_player_die() -> void:
	display()
