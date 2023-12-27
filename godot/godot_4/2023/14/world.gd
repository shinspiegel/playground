extends Node2D

@export var game_state: GameState
@export var battle_areas: Array[Battle]
@export var party: Array[Actor]


func _ready() -> void:
	for area in battle_areas:
		area.player_entered.connect(on_battle_start.bind(area))
		area.battle_ended.connect(on_battle_end.bind(area))


func on_battle_start(battle: Battle) -> void:
	print(battle)
	print("battle start")
	battle.start_battle(party)
	game_state.change_to_battle()


func on_battle_end(battle: Battle) -> void:
	print(battle)
	print("battle_ended")
	game_state.change_to_world()
