class_name Player extends KinematicBody2D

export(int) var speed = 100
export(int) var jump_speed = -200
export(int) var gravity = 400
export(float, 0, 1.0) var friction = 0.1
export(float, 0, 1.0) var acceleration = 0.25
export(Resource) var stats

onready var label: Label = $Label

var velocity = Vector2.ZERO


func _ready() -> void:
	var camera = Camera2D.new()
	camera.clear_current()
	camera.make_current()
	add_child(camera)

	var con = stats.hit_points_resource.connect("changed_detailed", self, "on_health_changed")

	if con != OK:
		print_debug("INFO:: Failed to connect")

	if stats.hit_points == 0:
		stats.hit_points_resource.set_to_max()

	stats.hit_points_resource.emit_signals()


func _physics_process(delta: float):
	if Input.is_action_just_pressed(KeysMap.PAUSE_GAME):
		stats.hurt(1)
		Manager.screen.open_pause_menu()

	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

	if Input.is_action_just_pressed(KeysMap.JUMP):
		if is_on_floor():
			velocity.y = jump_speed


func get_input():
	var dir = 0

	if Input.is_action_pressed(KeysMap.RIGHT):
		dir += 1

	if Input.is_action_pressed(KeysMap.LEFT):
		dir -= 1

	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func on_health_changed(value: int, _min_value: int, max_value: int) -> void:
	label.text = String(value) + "/" + String(max_value)
