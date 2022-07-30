class_name CutScene extends Node2D

signal moved_actor

export(Array, NodePath) var actor_list = []

var main_animator: AnimationPlayer
var actors = []
var started = false


func _ready() -> void:
	setup()


func _process(_delta: float) -> void:
	if not started:
		started = true
		play_scene()


func move_actor_to() -> void:
	yield(get_tree().create_timer(3), "timeout")

	# TODO: Make the actor move using tween
	
	emit_signal("moved_actor")


func play_scene() -> void:
	yield(get_tree().create_timer(3), "timeout")
	print("Finish waiting")

	move_actor_to()
	yield(self, "moved_actor")

	print("Moved actor")


func setup() -> void:
	for actor_path in actor_list:
		actors.append(get_node(actor_path))
