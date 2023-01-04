extends Sprite2D

@export var selected_frame: int = 0
@export var speed: int = 150
@export var speed_multiplier: float = 1.0


@onready var visibility: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	var layer = randi_range(0,3)
	selected_frame = randi_range(0, 4)
	
	speed += randi_range(-10, 10)
	frame = selected_frame
	visibility.screen_exited.connect(func(): queue_free())
	
	if(not layer == 0):
		var amount = 1/float(layer)
		scale.x -= amount
		scale.y -= amount
		modulate = Color(1,1,1,amount)


func _process(delta: float) -> void:
	global_position.y += (speed * speed_multiplier * delta)
