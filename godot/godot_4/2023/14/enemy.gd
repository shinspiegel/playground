class_name Enemy extends Actor


func act_turn() -> void:
	print("Make the action")
	turn_ended.emit()
