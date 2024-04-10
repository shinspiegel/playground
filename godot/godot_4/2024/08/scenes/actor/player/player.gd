class_name Player extends BaseActor


func _physics_process(delta: float) -> void:
	state_machine.update(delta)
