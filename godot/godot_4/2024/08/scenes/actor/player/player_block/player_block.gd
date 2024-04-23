class_name PlayerBlock extends CharacterBody2D

@export var actor: ActorData

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
