class_name World extends Node2D

@export var game_state: GameState

@onready var battle_ui: BattleUI = %BattleUI
@onready var sorted_container: Node2D = %Sorted
@onready var party_start_pos: Node2D = %PartyStartPos
@onready var main_camera: Camera2D = %MainCamera
@onready var battle_areas: Node2D = %BattleAreas


func _ready() -> void:
	spawn_party()

	for area in battle_areas.get_children():
		if area is Battle:
			__prepare_battle(area)
			__connect_battle(area)


func spawn_party() -> void:
	var party: Array[PlayerActor] = GameManager.party_data.get_party()

	for member in party:
		member.global_position = party_start_pos.global_position
		member.battle_ui = battle_ui
		member.camera = main_camera

		sorted_container.add_child(member)



func on_battle_start(battle: Battle) -> void:
	print("battle started::[%s]" % [battle.name])
	battle.start_battle()
	game_state.change_to_battle()


func on_battle_victory(battle: Battle) -> void:
	__disconnect_battle(battle)
	battle.queue_free()
	game_state.change_to_world()


func on_battle_defeat(battle: Battle) -> void:
	print("battle defeat::[%s]" % [battle.name])
	game_state.change_to_world()


func on_battle_run(battle: Battle) -> void:
	print("battle run::[%s]" % [battle.name])
	game_state.change_to_world()


# Private Methods!


func __prepare_battle(battle: Battle) -> void:
	battle.camera = main_camera
	battle.battle_ui = battle_ui


func __connect_battle(battle: Battle) -> void:
	battle.player_entered.connect(on_battle_start.bind(battle))
	battle.victory.connect(on_battle_victory.bind(battle))
	battle.defeat.connect(on_battle_defeat.bind(battle))
	battle.run.connect(on_battle_run.bind(battle))


func __disconnect_battle(battle: Battle) -> void:
	battle.player_entered.disconnect(on_battle_start.bind(battle))
	battle.victory.disconnect(on_battle_victory.bind(battle))
	battle.defeat.disconnect(on_battle_defeat.bind(battle))
	battle.run.disconnect(on_battle_run.bind(battle))
