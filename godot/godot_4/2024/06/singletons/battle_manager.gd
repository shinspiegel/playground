extends Node

signal battle_started()
signal battle_ended()
signal turn_started()
signal turn_ended()

var current_party: Array[PlayerActor] = []
var current_enemy_list: Array[EnemyActor] = []
var turn_order: Array[Actor] = []
var current_actor: Actor
var battle_area: BattleArea
var targets: Array[Actor] = []

func start_battle(party: Array[PlayerActor], enemies: Array[EnemyActor]) -> void:
	__prepare_lists(party, enemies)
	turn_order.sort_custom(__sort)

	GameManager.change_to_battle()
	battle_started.emit()
	start_turn()


func end_battle() -> void:
	__reset()
	GameManager.change_to_world()
	battle_ended.emit()


func start_turn() -> void:
	if __check_victory():
		end_battle()
		return

	current_actor = turn_order[0]
	turn_started.emit()

	if current_actor is EnemyActor:
		# Create AI usage
		await get_tree().create_timer(1).timeout
		next_turn()


func next_turn() -> void:
	turn_ended.emit()
	targets.clear()

	if __check_victory():
		end_battle()
		return

	var first = turn_order.pop_front()
	current_actor = turn_order.front()
	turn_order.push_back(first)
	start_turn()


func select_action(action: ActionCommand) -> void:
	print("select_action", action)
	action.act()
	next_turn()
	pass


func __reset() -> void:
	current_party = []
	current_enemy_list = []
	turn_order = []
	current_actor = null
	battle_area = null


func __prepare_lists(party: Array[PlayerActor], list: Array[EnemyActor]) -> void:
	current_party = party
	current_enemy_list = list

	turn_order.append_array(current_party)
	turn_order.append_array(current_enemy_list)


func __sort(a: Actor,b: Actor) -> bool:
	return a.actor_data.battle_speed > b.actor_data.battle_speed


func __check_victory() -> bool:
	# Check victory
	if turn_order.size() < 1:
		return true

	return false

