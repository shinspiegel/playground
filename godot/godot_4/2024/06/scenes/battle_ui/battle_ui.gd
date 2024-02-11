class_name BattleUI extends CanvasLayer

@onready var cursor_hand: Control = %CursorHand
@onready var actor_panel: Control = %ActorPanel


func _ready() -> void:
	BattleManager.battle_started.connect(on_battle_start)
	BattleManager.battle_ended.connect(on_battle_end)
	BattleManager.turn_started.connect(on_turn_started)
	hide_actor_panel()
	hide()


func move_hand_to(pos: Vector2) -> void:
	cursor_hand.global_position = pos


func show_actor_panel_at(pos: Vector2) -> void:
	actor_panel.global_position = pos
	actor_panel.show()


func hide_actor_panel() -> void:
	actor_panel.hide()


func on_battle_start() -> void:
	show()


func on_battle_end() -> void:
	hide()


func on_turn_started() -> void:
	var actor := BattleManager.current_turn
	move_hand_to(actor.get_cursor_position())

	if actor is PlayerActor:
		show_actor_panel_at(actor.get_cursor_position())


func on_action_select() -> void:
	hide_actor_panel()
