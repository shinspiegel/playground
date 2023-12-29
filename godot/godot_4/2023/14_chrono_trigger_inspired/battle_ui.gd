class_name BattleUI extends CanvasLayer

@export var battle: Battle
@export var damage_number_scene: PackedScene

@onready var character_data: VBoxContainer = %CharacterData
@onready var actions_buttons: VBoxContainer = %ActionsButtons
@onready var damage_container: Node2D = $DamageContainer
@onready var hand: Node2D = %Hand

@export_group("PRIVATE!!!")
@export var __current_actor: Actor


func _ready() -> void:
	hide()
	actions_buttons.hide()


func start(new_battle: Battle) -> void:
	battle = new_battle
	show()

	for actor in battle.combatent_ordered:
		actor.damaged.connect(on_receive_damage.bind(actor))

		if actor is Enemy:
			actor.focus.connect(on_focus.bind(actor))
			actor.selected.connect(on_target_select.bind(actor))

	hide_commands()


func end() -> void:
	for actor in battle.combatent_ordered:
		actor.damaged.disconnect(on_receive_damage.bind(actor))
		actor.focus.disconnect(on_focus.bind(actor))
		actor.selected.disconnect(on_target_select.bind(actor))

	hide_commands()
	actions_buttons.hide()


func enable_target_select() -> void:
	for target in battle.enemies:
		target.show_target()

	if not battle.enemies.is_empty():
		battle.enemies[0].grab_focus()


func on_target_select(_target: Actor) -> void:
	pass


func on_run_press() -> void:
	battle.end_battle(battle.END_STATE.RUN)
	pass


func show_command_for_actor(actor: Actor) -> void:
	__current_actor = actor

	for action in __current_actor.action_list:
		var button = Button.new()
		button.name = action.name
		button.text = action.name
		button.focus_entered.connect(on_focus.bind(button))
		button.pressed.connect(on_action_select.bind())

		actions_buttons.add_child(button)

	actions_buttons.show()


func hide_commands() -> void:
	actions_buttons.hide()


func move_hand_to(pos: Vector2) -> void:
	hand.global_position = pos


func on_focus(node) -> void:
	move_hand_to(node.get_global_transform_with_canvas().origin)


func on_action_select(_action: CombatAction) -> void:
	pass


func on_receive_damage(amount: int, actor: Actor) -> void:
	var damage: DamageNumber = damage_number_scene.instantiate()
	damage_container.add_child(damage)
	damage.set_damage(amount)
	damage.global_position = actor.get_global_transform_with_canvas().origin
