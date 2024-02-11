extends Node2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GRAVITY = 1200

signal screen_changed(size: Vector2i)
signal donuts_changed()
signal player_died()
signal game_started()

@export var screen_size: Vector2i = Vector2i.ZERO
@export var donuts_eaten: int = 0

func _ready() -> void:
	get_tree().get_root().size_changed.connect(on_resize)
	screen_size = get_tree().get_root().size


func on_resize() -> void:
	screen_size = get_window().size
	screen_changed.emit(screen_size)


func add_donuts() -> void:
	donuts_eaten += 1
	donuts_changed.emit()


func start_game() -> void:
	donuts_eaten = 0
	game_started.emit()
