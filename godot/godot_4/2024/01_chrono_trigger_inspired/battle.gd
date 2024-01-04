class_name Battle extends Area2D

enum END_STATE {VICTORY, DEFEAT, RUN}

signal player_entered()
signal victory()
signal defeat()
signal run()

@export var hero_positions: Array[Node2D] = []
@export var can_be_escaped: bool = true
@export var camera_center_position: Node2D

var battle_ui: BattleUI
var enemies: Array[Enemy]
var camera: Camera2D
var combatent_ordered: Array[Actor] = []

var __turn: int = 0


func _ready() -> void:
	if camera_center_position == null:
		print_debug("ERROR::Invalid or null 'camera_center_position'")
	body_entered.connect(on_body_enter)


func start_battle() -> void:
	__reset_state()
	__prepare_camera_for_battle()
	__move_hero_to_positions()
	__collect_enemies_on_area()
	__start_animation_for_enemies()
	__prepare_actors()

	battle_ui.start(self)
	start_actor_turn()


func end_victory() -> void: end_battle(END_STATE.VICTORY)
func end_defeat() -> void: end_battle(END_STATE.DEFEAT)
func end_run() -> void: end_battle(END_STATE.RUN)
func end_battle(state: END_STATE = END_STATE.VICTORY) -> void:
	battle_ui.end()
	__unprepare_actors()
	GameManager.set_camera_for_leader()

	match state:
		END_STATE.VICTORY:
			victory.emit()

		END_STATE.DEFEAT:
			defeat.emit()

		END_STATE.RUN:
			for enemy in enemies:
				if enemy.is_down(): enemy.queue_free()
			run.emit()


func start_actor_turn() -> void:
	var index: int = __turn % combatent_ordered.size()
	var current_actor = combatent_ordered[index]
	print("turn started::[%s] actor::[%s]" % [__turn, current_actor.name])
	current_actor.act_turn()


func get_first_ordered() -> Actor:
	return combatent_ordered[0]


func on_turn_end() -> void:
	if __has_combat_win():
		for enemy in enemies:
			enemy.queue_free()
		end_victory()
		return

	if __has_combat_lost():
		end_defeat()
		return

	__turn += 1
	start_actor_turn()


func on_body_enter(node: Node2D) -> void:
	if node == GameManager.get_leader():
		player_entered.emit()


func on_actor_die(actor: Actor) -> void:
	actor.anim_player.anim_die(actor.global_position.direction_to(hero_positions[0].global_position).normalized())



# Private Methods


func __reset_state() -> void:
	__turn = 0


func __prepare_camera_for_battle() -> void:
	for unit in GameManager.get_party():
		if unit is PlayerActor:
			unit.clean_camera()

	camera.global_position = camera_center_position.global_position


func __prepare_actors() -> void:
	combatent_ordered = []
	combatent_ordered.append_array(enemies)
	combatent_ordered.append_array(GameManager.party_data.get_party())
	combatent_ordered.sort_custom(__sort_combatent)

	for actor in combatent_ordered:
		actor.turn_ended.connect(on_turn_end)
		actor.actor_data.die.connect(on_actor_die.bind(actor))

		for action in actor.action_list:
			action.battle = self
			action.battle_ui = battle_ui


func __unprepare_actors() -> void:
	for actor in combatent_ordered:
		actor.turn_ended.disconnect(on_turn_end)
		actor.actor_data.die.disconnect(on_actor_die.bind(actor))


func __move_hero_to_positions() -> void:
	var party = GameManager.get_party()
	var tw = create_tween().set_parallel(true).set_ease(Tween.EASE_IN)

	for index in range(party.size()):
		var member: Actor = party[index]
		member.anim_player.anim_move(member.global_position.direction_to(camera.global_position).normalized())
		tw.tween_property(member, "global_position", hero_positions[index].global_position, 0.3)

	await tw.finished

	for index in range(party.size()):
		var member: Actor = party[index]
		member.anim_player.anim_move(member.global_position.direction_to(camera.global_position).normalized())


func __collect_enemies_on_area() -> void:
	enemies.clear()

	for body in get_overlapping_bodies():
		if body is Enemy:
			enemies.append(body)


func __sort_combatent(a: Actor, b: Actor) -> bool:
	return a.actor_data.speed < b.actor_data.speed


func __has_combat_win() -> bool:
	for enemy in enemies:
		if not enemy.is_down():
			return false

	return true


func __has_combat_lost() -> bool:
	return false


func __start_animation_for_enemies() -> void:
	for enemy in enemies:
		enemy.anim_player.anim_idle(enemy.global_position.direction_to(hero_positions[0].global_position).normalized())

