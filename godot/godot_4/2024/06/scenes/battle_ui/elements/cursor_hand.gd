class_name CursorHand extends Control

const DURATION = 0.2


func _ready() -> void:
	BattleManager.turn_started.connect(on_turn_started)
	BattleManager.turn_ended.connect(on_turn_ended)
	hide()


func move_hand_to(pos: Vector2) -> void:
	var tw = create_tween().set_ease(Tween.EASE_IN_OUT)
	tw.tween_property(self, "global_position", pos, DURATION)
	tw.play()


func on_turn_started() -> void:
	show()
	var actor := BattleManager.current_actor
	move_hand_to(actor.get_cursor_position())


func on_turn_ended() -> void:
	hide()
