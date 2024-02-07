class_name Bomb extends RigidBody2D

const EXPLOSION = preload("res://explosion/explosion.tscn")

@export var explosion_time: Timer
@export var range_limit: int = 200


func _ready() -> void:
	randomize_linear_velocity()
	randomize_timer()
	explosion_time.timeout.connect(kaboom)
	explosion_time.start()


func kaboom() -> void:
	var boom = EXPLOSION.instantiate()
	get_parent().add_child(boom)
	boom.global_position = global_position
	queue_free()



func randomize_timer() -> void:
	explosion_time.wait_time = randf_range(3, 5)

func randomize_linear_velocity() -> void:
	linear_velocity = Vector2(randi_range(-range_limit, range_limit), randi_range(100, 300))
