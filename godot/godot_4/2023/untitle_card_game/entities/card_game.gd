class_name CardGame extends CanvasLayer

@export var player: CharacterEntity
@export var enemy: EnemyEntity


func _ready() -> void:
	# TODO: finished_battle.pressed.connect(func(): SignalBus.battle_finished.emit())
	SignalBus.turn_ended_by.connect(on_turn_finished)
	SignalBus.battle_start_against.connect(start_battle_against)
	SignalBus.enemty_turn.connect(on_enemy_turn)
#	end_turn_button.pressed.connect(func(): SignalBus.turn_ended_by.emit(player))
	pass


func start_battle_against(target: CharacterEntity) -> void:
	enemy = target
	reset_battle_state()
	SignalBus.player_turn.emit()


func on_turn_finished(entity: CharacterEntity) -> void:
	if not has_card_game_finished():
		if entity == player:
			SignalBus.enemty_turn.emit()
		if entity == enemy:
			SignalBus.player_turn.emit()


func on_enemy_turn() -> void:
		# TODO: process enemy turn
		print("Turn enemy started")
		enemy.execute_turn()
		await get_tree().create_timer(1.0).timeout
		SignalBus.turn_ended_by.emit(enemy)
		print("Turn enemy ended")
		return


func has_card_game_finished() -> bool:
	if player.has_lost() or enemy.has_lost():
		if player.has_lost():
			print_debug("IMPLEMENT:: Play lost status!")
			SignalBus.card_game_lost.emit(enemy)
		
		if enemy.has_lost():
			print_debug("IMPLEMENT:: Enemy lost status!")
			SignalBus.card_game_won.emit(enemy)
		
		SignalBus.card_game_over.emit()
		return true
	
	return false


func reset_battle_state() -> void:
	player.reset()
	enemy.reset()
