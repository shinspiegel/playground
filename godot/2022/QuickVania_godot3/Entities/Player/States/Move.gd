extends BaseState


func _ready() -> void:
	if debug:
		print("INFO:: State ready [%s]" % [name])


func enter() -> void:
	if debug:
		print("INFO:: State entered [%s]" % [name])


func exit() -> void:
	if debug:
		print("INFO:: State exited [%s]" % [name])


func process(delta: float) -> void:
	if debug:
		print("INFO:: State process [%s] on delta [%s]" % [name, delta])
