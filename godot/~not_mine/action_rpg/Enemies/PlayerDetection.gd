extends Area2D

var PLAYER = null

func can_see_player():
	return PLAYER != null


func _on_PlayerDetection_body_entered(body):
	PLAYER = body


func _on_PlayerDetection_body_exited(_body):
	PLAYER = null
