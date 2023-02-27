class_name EnemyEntity extends CharacterEntity

@export var player: CharacterEntity
@export var possible_actions: Array[EnemyAction] = []

func execute_turn() -> void:
	var active_actions: Array[EnemyAction] = []
	var card_scene: PackedScene
	
	for action in possible_actions:
		if action.should_activate():
			active_actions.append(action)
	
	if active_actions.size() > 0:
		active_actions.shuffle()
		card_scene = active_actions[0].card_to_be_used
	else:
		card_scene = possible_actions[0].card_to_be_used
	
	var card_instance: CardBase = card_scene.instantiate()
	card_instance.activate(self, player)
