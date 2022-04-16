extends Area2D
class_name Hitbox

export(int) var damage := 1

onready var collider: CollisionShape2D = $Collisor

func active():
	collider.set_disabled(false)

func deactive():
	collider.set_disabled(true)
