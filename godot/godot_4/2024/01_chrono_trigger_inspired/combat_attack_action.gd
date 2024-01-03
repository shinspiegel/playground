class_name AttackAction extends CombatAction

@export var damage_factory: DamageFactory

func use_action(target: Actor = null) -> void:
	var damage = damage_factory.generate(actor.actor_data.attack)
	target.receive_damage(damage)
	actor.turn_ended.emit()
