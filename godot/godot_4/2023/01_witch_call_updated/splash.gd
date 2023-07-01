class_name SplashScreen extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const main = preload("res://main.tscn")


func _ready() -> void:
	animation_player.animation_finished.connect(func(_name): next())


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		next()


func next() -> void:
	get_tree().change_scene_to_packed(main)
