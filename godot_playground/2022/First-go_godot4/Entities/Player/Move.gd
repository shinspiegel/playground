extends BaseState

func enter() -> void:
	print("Entered Move")

func exit() -> void:
	print("Exited Move")

func action(delta: float) -> void:
	print("Update Move")
