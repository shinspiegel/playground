class_name BattleUI extends Control

@export var player: CharacterEntity
@export var enemy: CharacterEntity

@onready var player_label: Label = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer2/Control/Label
@onready var enemy_label: Label = $MarginContainer/CenterContainer/VBoxContainer/HBoxContainer2/Control2/Label

func _ready() -> void:
	SignalBus.turn_ended_by.connect(update_ui)
	SignalBus.battle_start_against.connect(on_battle_start)
	SignalBus.card_game_over.connect(on_card_game_over)
	hide()


func on_card_game_over() -> void:
	hide()


func on_battle_start(target: CharacterEntity) -> void:
	enemy = target
	update_ui(enemy)
	show()


func update_ui(_target) -> void:
	# Update the ui
	# TODO: Make the animation for the turn
	# TODO: After animation finished trigger signal for next turn
	player_label.text = "Player [%s/%s]" % [player.hp, player.max_hp]
	enemy_label.text = "Enemy [%s/%s]" % [enemy.hp, enemy.max_hp]
	pass
