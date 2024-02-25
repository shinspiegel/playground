class_name RangedAttack extends AttackAction


func act() -> void:
	BattleManager.targets_requested.emit()
	await BattleManager.targets_selected

	for target: Actor in BattleManager.target_list:
		attack_target(BattleManager.current_actor, target, "dex")

	finished.emit()

