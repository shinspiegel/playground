class_name RangedAttack extends ActionCommand


func act() -> void:
	BattleManager.targets_requested.emit()
	await BattleManager.targets_selected

	for target: Actor in BattleManager.target_list:
		__attack_target(BattleManager.current_actor, target)

	finished.emit()


func __attack_target(attacker: Actor, defender: Actor) -> void:
	var rand: int = attacker.get_attack("str")

	if rand > defender.get_armor():
		var dmg = Damage.new()
		dmg.is_critical = rand >= 20

		var left = attacker.actor_data.equip_left
		if not left == null and left is WeaponEquipament:
			# TODO: Make animation for attack
			dmg.amount = left.rand()

		var right = attacker.actor_data.equip_right
		if not right == null and right is WeaponEquipament:
			# TODO: Make animation for attack
			dmg.amount = right.rand()

		if dmg.amount <= 0:
			dmg.amount = 1

		defender.apply_damage(dmg)

