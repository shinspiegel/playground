extends Area2D

func _on_SpikeTRap_body_entered(body):
	if body.has_method("hurt"):
		body.hurt()