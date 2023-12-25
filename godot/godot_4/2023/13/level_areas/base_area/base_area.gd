class_name BaseArea extends Node2D

signal area_entered(name: String)

@export var game_camera: GameCamera
@export var transition_duration: float = 1.0

@onready var entry_area: Area2D = $EntryArea
@onready var top_left: Marker2D = $Limiter/TopLeft
@onready var bottom_right: Marker2D = $Limiter/BottomRight


func _ready() -> void:
	entry_area.body_entered.connect(on_player_enter)


func on_player_enter(body: Node2D) -> void:
	if body is Player:
		game_camera.set_limiters(
			int(top_left.global_position.y),
			int(bottom_right.global_position.y),
			int(top_left.global_position.x),
			int(bottom_right.global_position.x)
		)
		area_entered.emit(name)
