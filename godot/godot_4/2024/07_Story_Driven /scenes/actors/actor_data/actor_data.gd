class_name ActorData extends Resource

var speed: int = 500
var friction: int = 10

@export_group("Texture")
@export var base_texture: Texture2D
@export var body_texture: Texture2D
@export var head_texture: Texture2D


@export_group("Follow", "follow_")
@export_range(100, 300, 5) var follow_min_distance: int = 100
@export_range(500, 1000, 5) var follow_max_distance: int = 500
@export_range(0.0, 2.0, 0.05) var follow_ratio: float = 1.0
@export_range(0, 100, 5) var follow_distance: int = 20
@export_range(0.0, 2.0, 0.1) var follow_force_duration: float = 0.3
@export_range(0, 100, 5) var follow_angle: int = 45

