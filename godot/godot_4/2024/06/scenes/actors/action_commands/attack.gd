class_name AttackCommand extends ActionCommand


func act() -> void:
	BattleManager.targets_requested.emit()
	await BattleManager.targets_selected
	finished.emit()
