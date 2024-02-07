class_name Bomb extends Node2D

const EXPLOSION = preload("res://explosion/explosion.tscn")

@export var explosion_time: Timer


func _ready() -> void:
	explosion_time.timeout.connect(kaboom)
	explosion_time.start()


func kaboom() -> void:
	var boom = EXPLOSION.instantiate()
	get_parent().add_child(boom)
	boom.global_position = global_position
	queue_free()

