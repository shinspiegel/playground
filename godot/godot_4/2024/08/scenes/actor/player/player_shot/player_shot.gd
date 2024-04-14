class_name PlayerShoot extends Node2D

@export var speed: int = 1400
@export var movable: Node2D
@export var notifier: VisibleOnScreenNotifier2D


func _ready() -> void:
	notifier.screen_exited.connect(on_screen_exit)


func _physics_process(delta: float) -> void:
	movable.position.x += speed * delta


func on_screen_exit() -> void:
	queue_free()
