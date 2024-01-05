class_name ActorAnimPlayer extends AnimationPlayer

func anim_idle(blend: Vector2 = Vector2.ZERO) -> void: play_animation("idle", blend)
func anim_move(blend: Vector2 = Vector2.ZERO) -> void: play_animation("move", blend)
func anim_hurt(blend: Vector2 = Vector2.ZERO) -> void: play_animation("hurt", blend)
func anim_die(blend: Vector2 = Vector2.ZERO) -> void: play_animation("die", blend)
func anim_attack(blend: Vector2 = Vector2.ZERO) -> void: play_animation("attack", blend)

func play_animation(anim: String, blend: Vector2 = Vector2.ZERO) -> void:
	var dir_name: String = ""
	var dir = blend.angle()

	if dir >= -PI/4 and dir < PI/4:
		dir_name = "right"
	elif dir >= PI/4 and dir < 3*PI/4:
		dir_name = "down"
	elif dir >= -3*PI/4 and dir < -PI/4:
		dir_name = "up"
	else:
		dir_name = "left"

	play("%s_%s" % [anim, dir_name])
