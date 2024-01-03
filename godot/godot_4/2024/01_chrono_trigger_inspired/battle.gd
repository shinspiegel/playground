class_name Battle extends Area2D

enum END_STATE {VICTORY, DEFEAT, RUN}

signal player_entered()
signal victory()
signal defeat()
signal run()
signal combatend_changed()

@export var battle_ui: BattleUI
@export var hero_positions: Array[Node2D] = []
@export var can_be_escaped: bool = true

@export_group("Camera Definition")
@export var camera_center_position: Node2D
@export var camera: Camera2D

var enemies: Array[Enemy]
var combatent_ordered: Array[Actor] = []

var __turn: int = 0


func _ready() -> void:
	body_entered.connect(on_body_enter)


func start_battle() -> void:
	__reset_state()
	__move_hero_to_positions()
	__collect_enemies_on_area()
	__prepare_combatents()
	__prepare_camera_for_battle()
	__prepare_actors()

	battle_ui.start(self)
	start_actor_turn()


func end_victory() -> void: end_battle(END_STATE.VICTORY)
func end_run() -> void: end_battle(END_STATE.RUN)
func end_defeat() -> void: end_battle(END_STATE.DEFEAT)

func end_battle(state: END_STATE = END_STATE.VICTORY) -> void:
	for actor in combatent_ordered:
		actor.turn_ended.disconnect(on_turn_end)

	battle_ui.end()

	GameManager.set_camera_for_leader()

	match state:
		END_STATE.VICTORY: victory.emit()
		END_STATE.DEFEAT: defeat.emit()
		END_STATE.RUN: run.emit()


func start_actor_turn() -> void:
	var index: int = __turn % combatent_ordered.size()
	var current_actor = combatent_ordered[index]
	print("turn started::[%s] actor::[%s]" % [__turn, current_actor.name])
	current_actor.act_turn()


func get_first_ordered() -> Actor:
	return combatent_ordered[0]


func on_turn_end() -> void:
	# Check for winning
	# Check for losing
	__turn += 1
	start_actor_turn()


func on_body_enter(node: Node2D) -> void:
	if node == GameManager.get_leader():
		player_entered.emit()


func on_actor_die(actor: Actor) -> void:
	combatent_ordered.erase(actor)
	combatend_changed.emit()


# Private Methods


func __reset_state() -> void:
	__turn = 0


func __prepare_combatents() -> void:
	combatent_ordered = []
	combatent_ordered.append_array(enemies)
	combatent_ordered.append_array(GameManager.party_data.get_party())
	combatent_ordered.sort_custom(__sort_combatent)

	for actor in combatent_ordered:
		actor.actor_data.die.connect(on_actor_die.bind(actor))



func __prepare_camera_for_battle() -> void:
	for unit in GameManager.get_party():
		if unit is PlayerActor:
			unit.clean_camera()

	camera.global_position = camera_center_position.global_position


func __prepare_actors() -> void:
	for actor in combatent_ordered:
		actor.turn_ended.connect(on_turn_end)

		for action in actor.action_list:
			action.battle = self
			action.battle_ui = battle_ui


func __move_hero_to_positions() -> void:
	var party = GameManager.get_party()
	
	for index in range(party.size()):
		party[index].global_position = hero_positions[index].global_position


func __collect_enemies_on_area() -> void:
	for body in get_overlapping_bodies():
		if body is Enemy:
			enemies.append(body)


func __sort_combatent(a: Actor, b: Actor) -> bool:
	return a.actor_data.speed < b.actor_data.speed 
