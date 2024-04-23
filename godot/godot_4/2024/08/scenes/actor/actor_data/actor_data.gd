class_name ActorData extends Resource

@export var speed: float = 800.0
@export var jump_velocity: float = 1328.0

@export_group("Friction", "friction_")
@export_range(0.0, 2.0, 0.1) var friction_land: float = 1.0
@export_range(0.0, 2.0, 0.1) var friction_air: float = 0.5

