class_name Weapon1 extends BaseWeapon

const shoot_scene = preload("res://entities/player/player_weapons/base_player_shoot.tscn")


func shoot() -> void:
	if shoot_colddown.is_stopped():
		shoot_colddown.start()
		anim_player.play("shoot")
		var shot_intance = shoot_scene.instantiate()
		shot_intance.global_position = global_position
		shot_intance.rotation = rotation
		GameManager.spawn_shoot.emit(shot_intance)
