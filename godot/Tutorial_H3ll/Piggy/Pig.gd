extends Area2D

export(int) var SPEED = 50
export(float) var SCALE_FACTOR = 1.1

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

var DELTA = 0
var moving = false

func _process(delta: float) -> void:
	DELTA = delta
	moving = false
	
	if Input.is_action_pressed("ui_right"):
		move(SPEED, 0)
		sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		move(-SPEED, 0)
		sprite.flip_h = true
	if Input.is_action_pressed("ui_up"):
		move(0, -SPEED)
	if Input.is_action_pressed("ui_down"):
		move(0, SPEED)
	
	if moving == true:
		animationPlayer.play("Run")
	else:
		animationPlayer.play("Idle")
	
func move(x_speed, y_speed):
	position.x += x_speed * DELTA
	position.y += y_speed * DELTA
	moving = true


func _on_Pig_area_entered(area: Area2D) -> void:
	area.queue_free()
	scale *= SCALE_FACTOR
