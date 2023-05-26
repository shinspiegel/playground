extends Node3D

@export var first_level: PackedScene
@export var main_menu: PackedScene

@onready var play_again_button: Button = %PlayAgain
@onready var main_menu_button: Button = %MainMenu
@onready var quit_button: Button = %Quit
@onready var sub_title: Label = $UI/SubTitle
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	play_again_button.pressed.connect(on_play_again_pressed)
	main_menu_button.pressed.connect(on_main_menu_pressed)
	quit_button.pressed.connect(on_quit_pressed)
	
	main_menu_button.grab_focus()
	
	if GameManager.is_happy_score():
		animation_player.play("Jumping")
		sub_title.text = "You got %s coins.\nDebt payed!" % [GameManager.score]
	else:
		sub_title.text = "You got %s coins.\nSadly this is not enought!" % [GameManager.score]


func on_play_again_pressed() -> void:
	GameManager.level_manager.load_level("0")


func on_main_menu_pressed() -> void:
	GameManager.level_manager.load_level("main")


func on_quit_pressed() -> void:
	get_tree().quit()
