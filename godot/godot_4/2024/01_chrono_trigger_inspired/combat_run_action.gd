class_name RunAction extends CombatAction


func use_action(_target: Actor = null) -> void:
	if battle.can_be_escaped and randf_range(0.0, 1.0) < get_scape_chance():
		self.battle.end_run()


func get_scape_chance(base_value: float = 0.5, speed_factor: float = 0.1) -> float:
	var total_speed = 0.0
	var total_threat = 0.0

	for enemy in self.battle.enemies:
		total_speed += enemy.stat_speed * enemy.threat_level
		total_threat += enemy.threat_level

	return clampf(base_value + ((actor.stat_speed - (total_speed / total_threat)) * speed_factor), 0, 1)

