extends Node

signal battle_started()
signal battle_ended()

var current_party: Array[PlayerActor] = []
var current_enemy_list: Array[EnemyActor] = []
var turn_order: Array[Actor] = []


func start_battle(party: Array[PlayerActor], enemies: Array[EnemyActor]) -> void:
	__reset()
	__prepare_lists(party, enemies)
	turn_order.sort_custom(__sort)

	GameManager.change_to_battle()
	battle_started.emit()


func end_battle() -> void:
	__reset()
	GameManager.change_to_world()
	battle_ended.emit()


func start_turn() -> void:
	# turn order
	pass


func __reset() -> void:
	current_party = []
	current_enemy_list = []
	turn_order = []


func __prepare_lists(party: Array[PlayerActor], list: Array[EnemyActor]) -> void:
	current_party = party
	current_enemy_list = list

	turn_order.append_array(current_party)
	turn_order.append_array(current_enemy_list)


func __sort(a: Actor,b: Actor) -> bool:
	return a.actor_data.battle_speed > b.actor_data.battle_speed
