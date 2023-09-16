class_name Bullet extends Area2D

@export var direction: int = 1
@export_range(0.0, 10.0, 0.1) var speed: float = 1.0
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var __multiplier: float = 1000.0


func _ready() -> void:
	body_entered.connect(on_body_entered)
	visible_on_screen_notifier_2d.screen_exited.connect(on_screen_exited)


func _physics_process(delta: float) -> void:
	global_position.x += direction * (speed * __multiplier) * delta


func on_body_entered(_body: Node2D) -> void:
	queue_free()


func on_screen_exited() -> void:
	queue_free()
