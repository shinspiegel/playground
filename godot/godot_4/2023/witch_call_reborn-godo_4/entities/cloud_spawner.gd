extends Node2D

@onready var particles: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	particles.set_emitting(true)
