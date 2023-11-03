class_name BaseLevel extends Node2D

@export var player: Player
@export var camera: GameCamera
@export var initial_player_pos: Marker2D
@export var delay: float = 0.5


func _ready() -> void:
	await get_tree().create_timer(delay).timeout
	#LoadingManager.hide_loading()



func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		player.state_machine.change_to("die")
