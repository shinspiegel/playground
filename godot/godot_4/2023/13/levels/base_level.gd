class_name BaseLevel extends Node2D

@export var camera: GameCamera
@export var initial_player_pos: Marker2D


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print_debug("Kill player")
