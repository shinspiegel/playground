extends Label



func _on_StateMachine_state_changed(new_state) -> void:
	text = new_state
