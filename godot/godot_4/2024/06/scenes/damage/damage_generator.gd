class_name DamageGenerator extends Resource


@export var base_damage: int = 1
@export_range(0.0, 1.0, 0.1) var variation: float = 0.2
@export_range(0.0, 1.0, 0.1) var critical_chance: float = 0.1
@export_range(1.0, 3.0, 0.1) var critical_bonus: float = 1.5


func generate_for(attacker: Actor) -> Damage:
	var damage = Damage.new()

	damage.amount = randi_range(
		int(attacker.actor_data.battle_attack + base_damage - (attacker.actor_data.battle_attack + base_damage * variation)),
		int(attacker.actor_data.battle_attack + base_damage + (attacker.actor_data.battle_attack + base_damage * variation)),
	)

	if randf_range(0.0, 1.0) < critical_chance: 
		damage.is_critical = true
		damage.amount += (damage.amount * critical_bonus)

	return damage
