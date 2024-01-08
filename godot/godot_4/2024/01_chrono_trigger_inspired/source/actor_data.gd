class_name ActorData extends Resource

signal health_changed(health: int, max_health: int)
signal damaged(amount: int)
signal healed(amount: int)
signal die()

@export var name: String = "Unnamed Actor"
@export var actor_texture: Texture2D
@export var is_down: bool = false

@export var max_hit_points: int = 10
@export var hit_points: int = 10

@export var attack: int = 10
@export var defense: int = 5
@export var speed: int = 10


func _init() -> void:
	hit_points = max_hit_points


func receive_damage(amount: int) -> void:
	change_health(-amount)
	damaged.emit(amount)


func receive_healing(amount: int) -> void:
	change_health(amount)
	healed.emit(amount)


func change_health(amount: int) -> void:
	hit_points = clampi(hit_points + amount, 0, max_hit_points)
	health_changed.emit(hit_points, max_hit_points)

	if hit_points == 0:
		is_down = true
		die.emit()


