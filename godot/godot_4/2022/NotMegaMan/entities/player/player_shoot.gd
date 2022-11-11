class_name PlayerShot extends CharacterBody2D

@export var speed_multiplier: float = 12.0
@export var diretion: int = 1

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite: Sprite2D = $Sprite2D

var speed = Constants.BLOCK_SIZE * speed_multiplier


func _ready():
	visible_notifier.screen_exited.connect(func (): queue_free())
	sprite.flip_h = not diretion == 1


func _physics_process(delta: float) -> void:
	velocity.x = speed * diretion
	move_and_slide()
