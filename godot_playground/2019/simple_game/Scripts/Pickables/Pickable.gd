extends Area2D

export (int) var HEAL := 1

func _on_Pickable_body_entered(body):
	if body.name == "Player":
		if body.receive_heal(HEAL):
			queue_free()