extends BaseState

func enter() -> void:
	print("Entered Idle")

func exit() -> void:
	print("Exited Idle")

func action(delta: float) -> void:
	print("Update Idle")
