class_name Enemy extends Actor


func act_turn() -> void:
	print("Make the action")
	call_deferred("end")


func end() -> void:
	turn_ended.emit(0)
