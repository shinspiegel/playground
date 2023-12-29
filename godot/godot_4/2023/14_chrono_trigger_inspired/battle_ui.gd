class_name BattleUI extends CanvasLayer

signal target_selected()

@export var battle: Battle
@export var damage_number_scene: PackedScene

@onready var character_data: VBoxContainer = %CharacterData
@onready var actions_buttons: VBoxContainer = %ActionsButtons
@onready var damage_container: Node2D = $DamageContainer
@onready var hand: Node2D = %Hand

@export_group("PRIVATE!!!")
@export var __current_actor: Actor
@export var __current_target: Actor


func _ready() -> void:
	hand.hide()
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


func show_targets() -> void:
	for actor in battle.combatent_ordered:
		actor.show_target()

	if not battle.enemies.is_empty():
		battle.enemies[0].grab_focus()


func hide_targets() -> void:
	for actor in battle.combatent_ordered:
		actor.hide_target()


func on_target_select(target: Actor) -> void:
	__current_target = target
	target_selected.emit()


func on_run_press() -> void:
	battle.end_battle(battle.END_STATE.RUN)
	pass


func show_command_for_actor(actor: Actor) -> void:
	for node in actions_buttons.get_children():
		actions_buttons.remove_child(node)
		node.queue_free()

	__current_actor = actor

	for action in __current_actor.action_list:
		var button: Button = Button.new()
		button.name = action.name
		button.text = action.name
		button.focus_entered.connect(on_focus.bind(button))
		button.pressed.connect(on_action_select.bind(action))

		actions_buttons.add_child(button)

	actions_buttons.show()

	var first = actions_buttons.get_child(0)
	if first is Button:
		first.grab_focus()
		call_deferred("on_focus", first)



func hide_commands() -> void:
	actions_buttons.hide()
	hand.hide()


func move_hand_to(pos: Vector2) -> void:
	hand.show()
	hand.global_position = pos


func on_focus(node) -> void:
	move_hand_to(node.get_global_transform_with_canvas().origin)


func on_action_select(action: CombatAction) -> void:
	__current_target = null

	if action.require_target:
		show_targets()
		await target_selected

	action.use_action(__current_target)


func on_receive_damage(amount: int, actor: Actor) -> void:
	var damage: DamageNumber = damage_number_scene.instantiate()
	damage_container.add_child(damage)
	damage.set_damage(amount)
	damage.global_position = actor.get_global_transform_with_canvas().origin
