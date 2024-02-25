class_name AttackCommand extends ActionCommand

func act() -> void:
	BattleManager.targets_requested.emit()
	await BattleManager.targets_selected

	for target: Actor in BattleManager.target_list:
		var dmg = BattleManager.current_actor.generate_damage()
		target.apply_damage(dmg)

	finished.emit()
