extends Node2D

func _ready():
	$DamagePosition/AnimationPlayer.play("Damage")

func set_number(number : int) -> void:
	$DamagePosition/Label.text = str(number)

func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "Damage":
		queue_free()

func set_diretion(direction : int):
	if direction == -1:
		var scale = Vector2(-1,1)
		apply_scale(scale)