class_name MeleeAttack extends AttackAction


func act() -> void:
	BattleManager.targets_requested.emit()
	await BattleManager.targets_selected

	for target: Actor in BattleManager.target_list:
		attack_target(BattleManager.current_actor, target, "str")

	finished.emit()

