extends BaseState

onready var frontRay: RayCast2D = $FrontRay
onready var floorRay: RayCast2D = $FloorRay
onready var timer: Timer = $Timer

var direction = Vector2.RIGHT

func enter():
	.enter()
	timer.start()


# warning-ignore:unused_argument
func update_state(delta : float):
	character.input_vector = direction
	
	if timer.time_left == 0:
		if frontRay.is_colliding():
			timer.start()
			direction *= -1
		elif !floorRay.is_colliding():
			timer.start()
			direction *= -1
			emit_signal("finished", "Idle")


# warning-ignore:unused_argument
func handle_input(event : String):
	emit_signal("finished", "Chase")
