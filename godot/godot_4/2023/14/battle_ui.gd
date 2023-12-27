class_name BattleUI extends CanvasLayer

signal action_selected
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
	attack_button.pressed.connect(on_press.bind(attack_selected))
	defense_button.pressed.connect(on_press.bind(defense_selected))
	magic_button.pressed.connect(on_press.bind(magic_selected))
	run_button.pressed.connect(on_press.bind(run_selected))
	actions_buttons.hide()



func on_press(button_signal: Signal) -> void:
	button_signal.emit()
	action_selected.emit()


func show_commands() -> void:
	actions_buttons.show()
	attack_button.grab_focus()


func hide_commands() -> void:
	actions_buttons.hide()
