class_name RunCommandAction extends ActionCommand

@export var base_change: float = 0.5
@export var speed_factor: float = 0.5


func act() -> void:
	if not BattleManager.battle_area.can_be_escaped:
		return

	if randf_range(0.0, 1.0) < __generate_change():
		# TODO: Make the sucess animation
		BattleManager.end_battle()
	else:
		# TODO: Make the fail animation
		pass

	finished.emit()


func __generate_change() -> float:
	return clampf(base_change + (float(BattleManager.current_actor.actor_data.stat_dex_mod - __calculate_average()) * speed_factor), 0.0, 1.0)


func __calculate_average() -> float:
	var enemy_list: Array[int] = []
	var total_speed := 0

	for enemy: EnemyActor in BattleManager.current_enemy_list:
		enemy_list.append(enemy.actor_data.stat_dex_mod)
		total_speed += enemy.actor_data.stat_dex_mod

	return float(total_speed) / enemy_list.size()

