class_name Player extends KinematicBody2D

const InputKeys = {LEFT = "move_left", RIGHT = "move_right", JUMP = "jump"}

export(int) var speed = 100
export(int) var jump_speed = -200
export(int) var gravity = 400
export(float, 0, 1.0) var friction = 0.1
export(float, 0, 1.0) var acceleration = 0.25

onready var label: Label = $Label

onready var stats: PlayerStats = load("res://Entities/Player/PlayerStats.tres")

var velocity = Vector2.ZERO


func _ready() -> void:
	var camera = Camera2D.new()
	camera.clear_current()
	camera.make_current()
	add_child(camera)

	var con = stats.connect("health_changed", self, "on_health_changed")

	if con != OK:
		print_debug("INFO:: Failed to connect")

	on_health_changed(stats.current_value, stats.max_value)


func _physics_process(delta: float):
	if Input.is_action_just_pressed("pause_game"):
		Manager.screen.open_pause_menu()

	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_pressed(InputKeys.JUMP):
		if is_on_floor():
			velocity.y = jump_speed


func get_input():
	var dir = 0

	if Input.is_action_pressed(InputKeys.RIGHT):
		dir += 1

	if Input.is_action_pressed(InputKeys.LEFT):
		dir -= 1

	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func on_health_changed(value: int, max_value: int) -> void:
	label.text = String(value) + "/" + String(max_value)
