class_name AttackAction extends CombatAction

@export var damage_factory: DamageFactory

func use_action(target: Actor = null) -> void:
	var damage = damage_factory.generate(actor.actor_data.attack)

	# Actor: Move to the target
	# Actor: Attack Animation
	# Target: Hurt animation
	target.receive_damage(damage)
	# Target: Idle animation
	# Actor: Move to original position
	actor.turn_ended.emit()
