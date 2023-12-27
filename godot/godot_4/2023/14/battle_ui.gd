class_name BattleUI extends CanvasLayer

signal attack_selected
signal defense_selected
signal magic_selected
signal run_selected

@onready var character_data: VBoxContainer = %CharacterData
@onready var actions_buttons: VBoxContainer = %ActionsButtons

@onready var attack_button: Button = %AttackButton
@onready var defense_button: Button = %DefenseButton
@onready var magic_button: Button = %MagicButton
@onready var run_button: Button = %RunButton


func _ready() -> void:
	hide()
	attack_button.pressed.connect(func(): attack_selected.emit())
	defense_button.pressed.connect(func(): defense_selected.emit())
	magic_button.pressed.connect(func(): magic_selected.emit())
	run_button.pressed.connect(func(): run_selected.emit())

	actions_buttons.hide()
