class_name Enemy extends Actor

@export var threat_level: int = 10

func act_turn() -> void:
	print("Make the action")
	turn_ended.emit()


