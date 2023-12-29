class_name Battle extends Area2D

enum END_STATE {VICTORY, DEFEAT, RUN}

signal player_entered()
signal victory()
signal defeat()
signal run()

@export var battle_ui: BattleUI

@export_group("Player Definitions")
@export var watch_node: Node2D
@export var player_pos: Node2D

@export_group("Camera Definition")
@export var camera_center_position: Node2D
@export var camera: Camera2D

@export_group("Enemies Data")
@export var enemies: Array[Enemy]

@export_group("PRIVATE!!!!")
@export var combatent_ordered: Array[Actor] = []
@export var __party: Array[PlayerActor] = []
@export var __turn: int = 0


func _ready() -> void:
	body_entered.connect(on_body_enter)


func start_battle(party: Array[PlayerActor]) -> void:
	__reset_state(party)
	__prepare_combatents()
	__set_neighbors_enemies()
	__prepare_camera_for_battle()

	for actor in combatent_ordered:
		actor.turn_ended.connect(on_turn_end)

	battle_ui.start(self)

	start_actor_turn()



func end_battle(state: END_STATE = END_STATE.VICTORY) -> void:
	for actor in combatent_ordered:
		actor.turn_ended.disconnect(on_turn_end)

	battle_ui.end()

	__party[0].set_camera()

	match state:
		END_STATE.VICTORY: victory.emit()
		END_STATE.DEFEAT: defeat.emit()
		END_STATE.RUN: run.emit()


func start_actor_turn() -> void:
	var index: int = __turn % combatent_ordered.size()
	var current_actor = combatent_ordered[index]
	print("turn started::[%s] actor::[%s]" % [__turn, current_actor.name])
	current_actor.act_turn()


func on_turn_end() -> void:
	# Check for winning
	# Check for losing
	__turn += 1
	start_actor_turn()


func on_body_enter(node: Node2D) -> void:
	if node == watch_node:
		player_entered.emit()


# Private Methods


func __reset_state(party: Array[PlayerActor]) -> void:
	__party = party
	__turn = 0


func __prepare_combatents() -> void:
	combatent_ordered = []
	combatent_ordered.append_array(enemies)
	combatent_ordered.append_array(__party)
	combatent_ordered.sort_custom(func(a: Actor,b: Actor): return b.stat_speed - a.stat_speed)


func __set_neighbors_enemies() -> void:
	for index in range(enemies.size()):
		enemies[index].set_neighbor(
			enemies[posmod(index-1, enemies.size())].get_focus_path(),
			enemies[posmod(index+1, enemies.size())].get_focus_path(),
		)


func __prepare_camera_for_battle() -> void:
	for unit in __party:
		if unit is PlayerActor:
			unit.clean_camera()

	camera.global_position = camera_center_position.global_position


