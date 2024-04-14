class_name Player extends BaseActor

@export var input: PlayerInput
@export var power_ups: PowerUps

func _physics_process(delta: float) -> void:
	state_machine.update(delta)
