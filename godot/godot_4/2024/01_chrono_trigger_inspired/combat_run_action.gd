class_name RunAction extends CombatAction

@export_range(0.0, 1.0, 0.1) var base_value: float = 0.5
@export_range(0.0, 2.0, 0.1) var speed_factor: float = 0.1


func use_action(_target: Actor = null) -> void:
	if battle.can_be_escaped and randf_range(0.0, 1.0) < get_scape_chance():
		self.battle.end_run()


func get_scape_chance() -> float:
	var total_speed = 0.0
	var total_threat = 0.0

	for enemy in self.battle.enemies:
		if not enemy.actor_data.is_down:
			total_speed += enemy.actor_data.speed * enemy.threat_level
			total_threat += enemy.threat_level

	return clampf(base_value + ((actor.actor_data.speed - (total_speed / total_threat)) * speed_factor), 0, 1)

