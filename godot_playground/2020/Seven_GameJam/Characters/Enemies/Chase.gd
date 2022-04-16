extends BaseState

export(int) var MAX_SPEED := 70
export(int) var ACCELERATION := 600

onready var timer: Timer = $Timer
onready var frontRay: RayCast2D = $FrontRay

var original_max_speed :int
var original_acceleration :int
var direction = Vector2.RIGHT


func enter():
	.enter()
	accelerate_character()
	timer.start()


func exit():
	return_character_normal()
	.exit()


# warning-ignore:unused_argument
func update_state(delta : float):
	direction = character.flip_direction
	
	if character.is_on_floor() and frontRay.is_colliding():
		character.motion.y = -character.JUMP_FORCE


func _on_Timer_timeout() -> void:
	emit_signal("finished", "Idle")


func accelerate_character():
	original_max_speed = character.MAX_SPEED
	original_acceleration = character.ACCELERATION
	
	character.MAX_SPEED = MAX_SPEED
	character.ACCELERATION = ACCELERATION
	
	character.animationPlayer.set_speed_scale(1.5)


func return_character_normal():
	character.MAX_SPEED = original_max_speed
	character.ACCELERATION = original_acceleration
	
	character.animationPlayer.set_speed_scale(1.0)
