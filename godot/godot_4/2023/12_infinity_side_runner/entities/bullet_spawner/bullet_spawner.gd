class_name BulletSpawner extends Node2D

@export var bullet_scene: PackedScene
@export var delay: float = 0.3
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timeout)
	timer.start(delay)


func on_timeout() -> void:
	__spawn_bullet()


func __spawn_bullet() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	timer.start(delay)
