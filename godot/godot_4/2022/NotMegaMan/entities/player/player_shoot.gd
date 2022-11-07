class_name PlayerShot extends RigidBody2D

@export var speed_multiplier: float = 12.0
@export var diretion: int = 1

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite: Sprite2D = $Sprite2D

var speed = Constants.BLOCK_SIZE * speed_multiplier

func _ready():
	@warning_ignore(return_value_discarded)
	visible_notifier.screen_exited.connect(func (): queue_free())
	linear_velocity.x = speed * diretion
	sprite.flip_h = not diretion == 1
