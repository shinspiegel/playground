class_name Weapon1 extends BaseWeapon

const shoot_scene = preload("res://entities/player/player_weapons/base_player_shoot.tscn")


func shoot() -> void:
	if shoot_colddown.is_stopped():
		shoot_colddown.start()
		anim_player.play("shoot")
		var s = shoot_scene.instantiate()
		s.global_position = global_position
		s.rotation = rotation

		if s is BasePlayerShoot:
			s.direction = player.facing

		GameManager.spawn_shoot.emit(s)
