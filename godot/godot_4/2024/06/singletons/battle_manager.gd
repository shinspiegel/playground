extends Node

signal battle_started()


func start_battle(target_list: Array[EnemyActor]) -> void:
	print(target_list)
	battle_started.emit()

