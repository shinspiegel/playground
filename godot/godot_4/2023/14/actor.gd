class_name Actor extends CharacterBody2D

signal turn_ended()

@export var speed = 30000.0
@export var friction = 0.3
@export var stats: ActorStats


func act_turn() -> void:
	print_debug("WARN::Should implemente this on the inherited class")
	pass


func end_turn() -> void:
	turn_ended.emit()


func deferred_end() -> void:
	call_deferred("end_turn")
