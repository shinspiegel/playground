class_name AttackAction extends ActionCommand


func attack_target(attacker: Actor, defender: Actor, stat: String) -> void:
	var roll = randi_range(1, 20)
	var rand: int = attacker.get_attack(stat, roll)

	if rand > defender.get_armor():
		var dmg = Damage.new()
		dmg.is_critical = rand >= 20

		var left = attacker.actor_data.equip_left
		if not left == null and left is WeaponEquipament:
			# TODO: Make animation for attack
			dmg.amount += left.rand()
			dmg.amount += attacker.get_mod_for(stat)

		var right = attacker.actor_data.equip_right
		if not right == null and right is WeaponEquipament:
			# TODO: Make animation for attack
			dmg.amount += right.rand()
			dmg.amount += attacker.get_mod_for(stat)

		if dmg.amount <= 0:
			dmg.amount = 1

		defender.apply_damage(dmg)

