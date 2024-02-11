class_name BattleUI extends CanvasLayer

@onready var cursor_hand: Control = %CursorHand


func _ready() -> void:
	BattleManager.battle_started.connect(on_battle_start)
	BattleManager.battle_ended.connect(on_battle_end)
	hide()


func move_hand_to(pos: Vector2) -> void:
	cursor_hand.global_position = pos


func on_battle_start() -> void:
	show()


func on_battle_end() -> void:
	hide()

