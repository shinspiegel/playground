class_name AttackCommand extends ActionCommand

@export var damage_generator: DamageGenerator

func act() -> void:
	BattleManager.targets_requested.emit()
	await BattleManager.targets_selected

	for target: Actor in BattleManager.target_list:
		var dmg = damage_generator.generate_for(BattleManager.current_actor)
		target.apply_damage(dmg)

	finished.emit()
