class_name World extends Node2D

@export var game_state: GameState
@export var battle_areas: Array[Battle]
@export var battle_ui: BattleUI

@onready var sorted_container: Node2D = $Sorted
@onready var party_start_pos: Node2D = $PartyStartPos
@onready var main_camera: Camera2D = $MainCamera


func _ready() -> void:
	spawn_party()

	for area in battle_areas:
		area.watch_node = GameManager.party_data.get_leader()
		area.player_entered.connect(on_battle_start.bind(area))
		area.victory.connect(on_battle_victory.bind(area))
		area.defeat.connect(on_battle_defeat.bind(area))
		area.run.connect(on_battle_run.bind(area))


func spawn_party() -> void:
	var party: Array[PlayerActor] = GameManager.party_data.get_party()

	for index in range(party.size()):
		var member: PlayerActor = party[index]

		member.global_position = party_start_pos.global_position
		member.battle_ui = battle_ui
		member.camera = main_camera

		if index == 0:
			member.is_active = true

		sorted_container.add_child(member)



func on_battle_start(battle: Battle) -> void:
	print("battle started::[%s]" % [battle.name])
	battle.start_battle()
	game_state.change_to_battle()


func on_battle_victory(battle: Battle) -> void:
	print("battle victory::[%s]" % [battle.name])
	game_state.change_to_world()


func on_battle_defeat(battle: Battle) -> void:
	print("battle defeat::[%s]" % [battle.name])
	game_state.change_to_world()


func on_battle_run(battle: Battle) -> void:
	print("battle run::[%s]" % [battle.name])
	game_state.change_to_world()

