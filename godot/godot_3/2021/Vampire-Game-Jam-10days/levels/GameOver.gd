extends Control

func _unhandled_input(event: InputEvent) -> void:
	get_tree().quit()

func _on_Timer_timeout() -> void:
	get_tree().quit()
