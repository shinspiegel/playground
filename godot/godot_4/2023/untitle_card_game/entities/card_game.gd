class_name CardGame extends CanvasLayer

@export var player: CharacterEntity
@export var enemy: CharacterEntity


func _ready() -> void:
	# TODO: finished_battle.pressed.connect(func(): SignalBus.battle_finished.emit())
	SignalBus.turn_ended_by.connect(on_turn_finished)
	SignalBus.battle_start_against.connect(start_battle_against)
	SignalBus.enemty_turn.connect(on_enemy_turn)
#	end_turn_button.pressed.connect(func(): SignalBus.turn_ended_by.emit(player))


func start_battle_against(target: CharacterEntity) -> void:
	enemy = target
	reset_battle_state()
	SignalBus.player_turn.emit()


func on_turn_finished(entity: CharacterEntity) -> void:
	check_end_battle()
	
	if entity == player:
		SignalBus.enemty_turn.emit()
		return 
	if entity == enemy:
		SignalBus.player_turn.emit()
		return 


func on_enemy_turn() -> void:
		# TODO: process enemy turn
		print("Turn enemy started")
		await get_tree().create_timer(1.0).timeout
		SignalBus.turn_ended_by.emit(enemy)
		print("Turn enemy ended")
		return


func check_end_battle() -> void:
#	print_debug("IMPLEMENT:: Check for the victory condition")
	pass


func reset_battle_state() -> void:
	player.reset()
	enemy.reset()
#	player_hand.position.y = 400
#	hide_hand()
	pass
