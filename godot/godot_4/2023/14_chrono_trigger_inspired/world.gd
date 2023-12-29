class_name World extends Node2D

@export var game_state: GameState
@export var battle_areas: Array[Battle]
@export var party: Array[PlayerActor]


func _ready() -> void:
	party[0].set_camera()

	for area in battle_areas:
		area.player_entered.connect(on_battle_start.bind(area))
		area.victory.connect(on_battle_victory.bind(area))
		area.defeat.connect(on_battle_defeat.bind(area))
		area.run.connect(on_battle_run.bind(area))


func on_battle_start(battle: Battle) -> void:
	print("battle started::[%s]" % [battle.name])
	battle.start_battle(party)
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

