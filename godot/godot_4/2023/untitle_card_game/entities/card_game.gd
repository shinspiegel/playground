class_name CardGame extends CanvasLayer

@export var player: CharacterEntity
@export var enemy: CharacterEntity

@onready var end_turn_button: Button = %EntTurnButton/Button
@onready var player_hand: Control = %Hand
@onready var DEBUG_LABEL: Label = %DEBUG_LABEL


func _ready() -> void:
	# TODO: finished_battle.pressed.connect(func(): SignalBus.battle_finished.emit())
	SignalBus.turn_ended_by.connect(on_turn_finished)
	SignalBus.battle_start_against.connect(start_battle_against)
	SignalBus.selected_card_data.connect(on_card_selected)
	end_turn_button.pressed.connect(func(): SignalBus.turn_ended_by.emit(player))


func start_battle_against(target: CharacterEntity) -> void:
	enemy = target
	reset_battle_state()
	turn(player)


func on_turn_finished(entity: CharacterEntity) -> void:
	hide_hand()
	check_end_battle()
	
	if entity == player:
		turn(enemy)
		return 
	if entity == enemy:
		turn(player)
		return 


func turn(entity: CharacterEntity) -> void:
	DEBUG_LABEL.text = "Turn [%s]" % [entity.resource_name]
	
	if entity == player:
		# TODO: Process with player stuff
		SignalBus.player_turn.emit()
		show_hand()
		return
	
	if entity == enemy:
		# TODO: process enemy turn
		SignalBus.enemty_turn.emit()
		print("Turn enemy started")
		await get_tree().create_timer(1.0).timeout
		SignalBus.turn_ended_by.emit(entity)
		print("Turn enemy ended")
		return


func check_end_battle() -> void:
	print_debug("IMPLEMENT:: Check for the victory condition")


func reset_battle_state() -> void:
	player_hand.position.y = 400
	hide_hand()
	print_debug("IMPLEMENT:: Reset player/enemy state if any")


func show_hand() -> void:
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_property(player_hand, "position:y", 250, 0.3)
	tw.play()
	await tw.finished
	player_hand.get_child(0).get_child(0).get_child(0).grab_focus()


func hide_hand() -> void:
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_property(player_hand, "position:y", 400, 0.2)
	tw.play()
	await tw.finished
	end_turn_button.release_focus()


func on_card_selected(card: CardData) -> void:
	# Assume that this is a player interaction, so the card should be player only
	card.activate(player, enemy)
	SignalBus.turn_ended_by.emit(player)
