class_name BattleResult extends Control

@onready var battle_lost: Control = $MarginContainer/VBoxContainer/Control/BattleLost
@onready var battle_won: Control = $MarginContainer/VBoxContainer/Control/BattleWon
@onready var close: Button = $MarginContainer/VBoxContainer/CenterContainer/Button


func _ready() -> void:
	SignalBus.card_game_won.connect(on_player_won)
	SignalBus.card_game_lost.connect(on_player_lost)
	SignalBus.battle_start_against.connect(on_battle_start)
	close.pressed.connect(on_close_press)
	battle_won.hide()
	battle_lost.hide()
	hide()


func on_battle_start(_entity: CharacterEntity) -> void:
	hide()


func on_close_press() -> void:
	SignalBus.battle_finished.emit()


func on_player_won(target: CharacterEntity) -> void:
	show()
	battle_won.show()
	close.grab_focus()


func on_player_lost(target: CharacterEntity) -> void:
	show()
	battle_lost.show()
	close.grab_focus()
