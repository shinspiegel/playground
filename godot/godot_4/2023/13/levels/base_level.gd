class_name BaseLevel extends Node2D

@export var debug: Debugger
@export var player_scene: PackedScene
@export var camera: GameCamera
@export var initial_player_pos: Marker2D

var __player: Player

func _ready() -> void:
	__spawn_player()


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		__player.state_machine.change_to("die")


## Private Methods

func __spawn_player() -> void:
	var pos: Vector2 = GameManager.get_last_checkpoint_pos()
	
	if pos == null:
		pos = initial_player_pos.global_position
	
	var player = player_scene.instantiate()
	
	if debug:
		debug.set_player(player)
	
	if player is Player:
		player.camera = camera
		player.global_position = pos
		
		## REMOVE IT
		__player = player
	
	add_child(player)
