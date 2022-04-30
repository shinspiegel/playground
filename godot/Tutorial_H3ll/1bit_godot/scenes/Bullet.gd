extends RigidBody2D

class_name Bullet

const HitEffect = preload("res://scenes/HitSound.tscn")

export(int) var damage = 1
onready var laserSound = $AudioStreamPlayer

func _ready() -> void:
	laserSound.play()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
