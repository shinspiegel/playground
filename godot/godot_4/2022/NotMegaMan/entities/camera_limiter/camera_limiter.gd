class_name CameraLimiter extends Area2D

@export var camera_path: NodePath

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var shape: Rect2 = collision.get_shape().get_rect()

var camera: Camera2D
var is_active: bool = false

func _ready() -> void:
	if not camera_path.is_empty():
		camera = get_node(camera_path)
	
	body_entered.connect(on_player_enter)
	body_exited.connect(on_player_exited)
	collision.set_disabled(true)


func _process(_delta: float) -> void:
	if collision.is_disabled():
		collision.set_disabled(false)
	
	if not collision.is_disabled() and not is_active:
		for body in get_overlapping_bodies():
			if body is Player:
				on_player_enter(body)


func on_player_enter(body: Node2D) -> void:
	if body is Player:
		is_active = true
		
		var start_pos_x = collision.global_position.x + shape.position.x
		var start_pos_y = collision.global_position.y + shape.position.y
		var end_pos_x = collision.global_position.x + shape.position.x + shape.size.x
		var end_pox_y = collision.global_position.y + shape.position.y + shape.size.y
		
		# TODO: Need to figure out how to ease this moving
#		var duration = 0.5
#		var tween = get_tree().create_tween().set_parallel(true).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
#		tween.tween_property(camera, "limit_left", start_pos_x, duration)
#		tween.tween_property(camera, "limit_top", start_pos_y, duration)
#		tween.tween_property(camera, "limit_right", end_pos_x, duration)
#		tween.tween_property(camera, "limit_bottom", end_pox_y, duration)
		
		camera.limit_left = int(start_pos_x)
		camera.limit_top = int(start_pos_y)
		camera.limit_right = int(end_pos_x)
		camera.limit_bottom = int(end_pox_y)


func on_player_exited(body: Node2D) -> void:
	if body is Player:
		is_active = false
