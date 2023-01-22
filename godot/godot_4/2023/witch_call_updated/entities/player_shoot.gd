class_name PlayerShoot extends Area2D


@export var speed: float = 120

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hit_box: HitBox = $HitBox


func _ready() -> void:
	notifier.screen_exited.connect(func(): queue_free())
	hit_box.hit.connect(func(_hurt_box): queue_free())


func _process(delta: float) -> void:
	position.y -= delta * speed
