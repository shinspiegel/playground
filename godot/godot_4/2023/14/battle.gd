class_name Battle extends Area2D

signal player_entered()
signal battle_ended()

@export_group("Player Definitions")
@export var watch_node: Node2D
@export var player_pos: Node2D

@export_group("Enemies Data")
@export var enemies: Array[Enemy]

@export_group("Battle Status")
@export var battle_ui: BattleUI

@export var __combatent_ordered: Array[Actor] = []
@export var __turn: int = 0


func _ready() -> void:
	body_entered.connect(on_body_enter)


func start_actor_turn() -> void:
	print("turn started::[%s]" % [__turn])
	var index: int =  __turn % __combatent_ordered.size()
	var current_actor = __combatent_ordered[index]
	current_actor.act_turn()


func on_turn_end() -> void:
	print("turn started::[%s]" % [__turn])
	__turn += 1
	start_actor_turn()


func on_body_enter(node: Node2D) -> void:
	if node == watch_node:
		player_entered.emit()



func start_battle(party: Array[Actor]) -> void:
	__combatent_ordered.append_array(enemies)
	__combatent_ordered.append_array(party)
	__combatent_ordered.sort_custom(func(a: Actor,b: Actor): return b.stats.speed < a.stats.speed)

	for actor in __combatent_ordered:
		actor.turn_ended.connect(on_turn_end)

	battle_ui.show()
	__turn = 0

	start_actor_turn()



func end_battle() -> void:
	battle_ended.emit()
	__turn = 0
