class_name BattleUI extends CanvasLayer


@export var battle: Battle
@onready var character_data: VBoxContainer = %CharacterData
@onready var actions_buttons: VBoxContainer = %ActionsButtons

@onready var attack_button: Button = %AttackButton
@onready var defense_button: Button = %DefenseButton
@onready var magic_button: Button = %MagicButton
@onready var run_button: Button = %RunButton
@onready var hand: Node2D = %Hand

@export_group("PRIVATE!!!")
@export var __current_actor: Actor


func _ready() -> void:
	hide()
	#attack_button.pressed.connect(on_attack_press)
	#defense_button.pressed.connect(on_press)
	#magic_button.pressed.connect(on_press)
	run_button.pressed.connect(on_run_press)

	attack_button.focus_entered.connect(on_focus.bind(attack_button))
	defense_button.focus_entered.connect(on_focus.bind(defense_button))
	magic_button.focus_entered.connect(on_focus.bind(magic_button))
	run_button.focus_entered.connect(on_focus.bind(run_button))

	actions_buttons.hide()


func on_attack_press() -> void:
	# Select target
	# Emit signal
	__current_actor.turn_ended.emit()
	pass


func on_run_press() -> void:
	# Make logic to run
	# Trigger battle run on the __battle
	battle.end_battle(battle.END_STATE.RUN)
	pass


func on_focus(node: Control) -> void:
	move_hand_to(node.global_position)


func show_command_for_actor(actor: Actor) -> void:
	__current_actor = actor
	actions_buttons.show()
	attack_button.grab_focus()


func hide_commands() -> void:
	actions_buttons.hide()


func move_hand_to(pos: Vector2) -> void:
	hand.global_position = pos
