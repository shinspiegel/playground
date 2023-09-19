extends Node2D

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("die")
	$AudioStreamPlayer2D.play()
	$Area2D/CollisionShape2D.disabled = true
	if body.has_method("coin_collect"):
		body.coin_collect()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()