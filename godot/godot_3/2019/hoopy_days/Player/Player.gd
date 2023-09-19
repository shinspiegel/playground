extends KinematicBody2D

var motion: Vector2 = Vector2(0,0)

const SPEED = 1000
const GRAVITY = 200
const UP = Vector2(0, -1)
const JUMP_SPEED = 3000
const WORLD_LIMIT = 4000
const BOOST = JUMP_SPEED * 2

var lifes = 3
var coins = 0
var coin_limit = 2

signal animate
signal life_change
signal coin_change

func _ready():
	update_gui()
	pass
	
func _physics_process(delta):
	apply_gravity()
	move()
	jump()
	animate()
	move_and_slide(motion, UP)

func apply_gravity():
	if position.y > WORLD_LIMIT:
		end_game()
	
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY

func move():
	if Input.is_action_pressed('ui_left') and Input.is_action_pressed("ui_right"):
		motion.x = 0
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	else:
		motion.x = 0

func jump():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		motion.y = -JUMP_SPEED
		play_sound("jump")

func hurt():
	position.y -= 1
	yield(get_tree(), 'idle_frame')
	motion.y = -JUMP_SPEED
	lifes -= 1
	update_gui()
	
	if lifes <= 0:
		end_game()
	
	play_sound("hurt")

func life_gain():
	lifes += 1
	update_gui()

func coin_collect():
	coins += 1
	if coins >= coin_limit:
		life_gain()
		coins = 0
	update_gui()

func update_gui():
	emit_signal("life_change", lifes)
	emit_signal("coin_change", coins)


func play_sound(sound):
	if (sound == 'jump'):
		get_node("Audio/Jump").play()
	if (sound == 'hurt'):
		get_node("Audio/Hurt").play()
	
func boost():
	motion.y = -BOOST

func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")

func animate():
	emit_signal("animate", motion)
