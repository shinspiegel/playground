extends Node

signal battle_started()
signal battle_ended()

var current_party: Array[PlayerActor] = []
var current_enemy_list: Array[EnemyActor] = []


func start_battle(party: Array[PlayerActor], list: Array[EnemyActor]) -> void:
	current_party = party
	current_enemy_list = list
	GameManager.change_to_battle()
	battle_started.emit()


func end_battle() -> void:
	current_enemy_list = []
	GameManager.change_to_world()
	battle_ended.emit()

