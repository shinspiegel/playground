extends Node2D

onready var particle = $Particles2D

func _ready() -> void:
	particle.set_emitting(true)


func _on_Timer_timeout() -> void:
	queue_free()
