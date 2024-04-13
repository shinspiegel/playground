class_name ActorData extends Resource

@export var speed: float = 800.0
@export var jump_velocity: float = 1200.0

@export_group("Friction", "friction_")
@export_range(0.0, 2.0, 0.1) var friction_land: float = 1.0
@export_range(0.0, 2.0, 0.1) var friction_air: float = 0.5

@export_group("Acceleration", "acceleration_")
@export_range(0.0, 1.0, 0.1) var acceleration_land: float = 0.1
@export_range(0.0, 1.0, 0.1) var acceleration_idle: float = 0.5
@export_range(0.0, 1.0, 0.1) var acceleration_falling: float = 0.05
@export_range(0.0, 1.0, 0.1) var acceleration_jump: float = 0.05


