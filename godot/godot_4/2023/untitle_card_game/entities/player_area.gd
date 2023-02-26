class_name PlayerArea extends Control

signal hand_displayed()

@export var player: CharacterEntity
@export var enemy: CharacterEntity

@onready var end_turn_button: Button = %EntTurnButton/Button
@onready var player_hand: Control = %Hand
@onready var cards_container: HBoxContainer = %CardsContainer
@onready var drawing_pile: Control = %DrawingPile
@onready var discard_pile: Control = %DiscardPile


func _ready() -> void:
	SignalBus.battle_start_against.connect(on_battle_start)
	SignalBus.selected_card_data.connect(on_card_selected)
	SignalBus.player_turn.connect(on_player_turn)
	SignalBus.turn_ended_by.connect(on_turn_end)
	end_turn_button.pressed.connect(end_turn_pressed)


func on_battle_start(target: CharacterEntity) -> void:
	enemy = target
	initial_deck_shuffle()
	pass


func initial_deck_shuffle() -> void:
	var cloned_deck = player.deck.duplicate()
	cloned_deck.shuffle()
	
	for card in cloned_deck:
		drawing_pile.add_child(card.instantiate())


func reshuffle() -> void:
	var shuffle_cards = []
	
	for card in discard_pile.get_children():
		discard_pile.remove_child(card)
		shuffle_cards.append(card)
	
	shuffle_cards.shuffle()
	
	for card in shuffle_cards:
		drawing_pile.add_child(card)


func on_player_turn() -> void:
	show_hand()
	await hand_displayed
	
	for _index in range(player.hand_size):
		draw_card()
	
	grab_selection_focus()


func draw_card() -> void:
	if drawing_pile.get_child_count() <= 0:
		reshuffle()
	
	var card = drawing_pile.get_child(0)
	drawing_pile.remove_child(card)
	cards_container.add_child(card)


func grab_selection_focus() -> void:
	if cards_container.get_child_count() > 0:
		cards_container.get_child(0).focus()
	else:
		end_turn_button.grab_focus()


func show_hand() -> void:
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_property(player_hand, "position:y", 250, 0.3)
	tw.play()
	await tw.finished
	hand_displayed.emit()


func hide_hand() -> void:
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.tween_property(player_hand, "position:y", 400, 0.2)
	tw.play()
	await tw.finished


func end_turn_pressed() -> void:
	hide_hand()
	discard_hand()
	end_turn_button.release_focus()
	SignalBus.turn_ended_by.emit(player)


func discard_hand() -> void:
	for card in cards_container.get_children():
		cards_container.remove_child(card)
		discard_pile.add_child(card)


func on_card_selected(card: CardBase) -> void:
	card.activate(player, enemy)
	discard_hand()
	SignalBus.turn_ended_by.emit(player)


func on_turn_end(_entity: CharacterEntity) -> void:
	hide_hand()
