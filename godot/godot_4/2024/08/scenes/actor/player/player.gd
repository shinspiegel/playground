class_name Player extends BaseActor

@export var input: BaseInputs


func _physics_process(delta: float) -> void:
	state_machine.update(delta)
