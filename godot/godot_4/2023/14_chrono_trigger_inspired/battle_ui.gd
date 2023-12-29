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
	actions_buttons.hide()


func start(new_battle: Battle) -> void:
	battle = new_battle

	show()

	attack_button.pressed.connect(on_attack_press)
	#defense_button.pressed.connect(on_press)
	#magic_button.pressed.connect(on_press)
	run_button.pressed.connect(on_run_press)

	attack_button.focus_entered.connect(on_focus.bind(attack_button))
	defense_button.focus_entered.connect(on_focus.bind(defense_button))
	magic_button.focus_entered.connect(on_focus.bind(magic_button))
	run_button.focus_entered.connect(on_focus.bind(run_button))

	for enemy in battle.enemies:
		enemy.focus.connect(on_focus.bind(enemy))
		enemy.selected.connect(on_target_select.bind(enemy))

	actions_buttons.hide()


func end() -> void:
	attack_button.pressed.disconnect(on_attack_press)
	#defense_button.pressed.disconnect(on_press)
	#magic_button.pressed.disconnect(on_press)
	run_button.pressed.disconnect(on_run_press)

	attack_button.focus_entered.disconnect(on_focus.bind(attack_button))
	defense_button.focus_entered.disconnect(on_focus.bind(defense_button))
	magic_button.focus_entered.disconnect(on_focus.bind(magic_button))
	run_button.focus_entered.disconnect(on_focus.bind(run_button))

	for enemy in battle.enemies:
		enemy.focus.disconnect(on_focus.bind(enemy.target_control))
		enemy.selected.disconnect(on_target_select.bind(enemy))
	
	hide()
	actions_buttons.hide()


func on_attack_press() -> void:
	actions_buttons.hide()
	select_target()


func select_target() -> void:
	for target in battle.enemies:
		target.show_target()

	if not battle.enemies.is_empty():
		battle.enemies[0].grab_focus()


func on_target_select(target: Actor) -> void:
	__current_actor.attack_target(target)


func on_run_press() -> void:
	battle.end_battle(battle.END_STATE.RUN)
	pass


func show_command_for_actor(actor: Actor) -> void:
	__current_actor = actor
	actions_buttons.show()
	attack_button.grab_focus()


func hide_commands() -> void:
	actions_buttons.hide()



func on_focus(node) -> void:
	move_hand_to(node.get_global_transform_with_canvas().origin)


func move_hand_to(pos: Vector2) -> void:
	print("Moved hand to::[%s]" % [pos])
	hand.global_position = pos
