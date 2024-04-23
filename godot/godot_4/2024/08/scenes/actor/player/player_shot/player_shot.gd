class_name PlayerShoot extends Node2D

@export var speed: int = 1400
@export var dir: int = 1

@onready var movable: Node2D = %Movable
@onready var notifier: VisibleOnScreenNotifier2D = %VisibleOnScreenNotifier2D
@onready var damage_inflictor: DamageInflictor = %DamageInflictor
@onready var wall_detection: Area2D = %WallDetector


func _ready() -> void:
	notifier.screen_exited.connect(on_exit_screen)
	wall_detection.body_entered.connect(on_wall_hit)


func _physics_process(delta: float) -> void:
	movable.position.x += speed * delta * dir


func on_wall_hit(_body: Node2D) -> void:
	queue_free()


func on_exit_screen() -> void:
	queue_free()
