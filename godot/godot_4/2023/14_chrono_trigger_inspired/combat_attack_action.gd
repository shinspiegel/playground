class_name AttackAction extends CombatAction

func use_action(target: Actor = null) -> void:
	var damage_variation = float(actor.stat_attack * actor.stat_damage_variation)
	var damage = randi_range(
		actor.stat_attack - damage_variation,
		actor.stat_attack + damage_variation,
	)

	if randf_range(0.0, 1.0) < actor.stat_crit_chance:
		damage += damage * actor.stat_crit_bonus

	target.receive_damage(damage)
	actor.turn_ended.emit()
