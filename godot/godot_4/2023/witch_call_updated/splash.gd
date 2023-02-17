class_name SplashScreen extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const main = preload("res://main.tscn")


func _ready() -> void:
	animation_player.animation_finished.connect(func(_name): next())


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		next()


func next() -> void:
	get_tree().change_scene_to_packed(main)
