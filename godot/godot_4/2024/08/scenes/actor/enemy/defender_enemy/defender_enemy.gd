extends BaseEnemy


func on_receive_damage(dmg: Damage) -> void:
	if not is_on_hit() or is_on_death():
		if is_damage_from_face(dmg.source_position):
			GameManager.spawn_damage_text(damage_position.global_position)
		else:
			GameManager.spawn_damage_number(dmg, damage_position.global_position)
			receive_damage(dmg.amount)
			state_machine.change_by_state(hit_state)


func is_damage_from_face(pos: Vector2) -> bool:
	if clampi(int(pos.x - global_position.x), -1, 1) == clampi(direction, -1, 1):
		return true
	return false
