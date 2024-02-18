class_name ActorData extends Resource


@export_group("World Data")
@export var speed: int = 300
@export var friction: float = 10


@export_group("Battle Data", "battle_")
@export var battle_max_hp: int = 10
@export var battle_attack: int = 5
@export var battle_defense: int = 2
@export var battle_speed: int = 5


@export_group("Texture")
@export var base_texture: Texture2D
@export var body_texture: Texture2D
@export var head_texture: Texture2D


@export_group("Follow", "follow_")
@export_range(100, 300, 5) var follow_min_distance: int = 50
@export_range(0.0, 2.0, 0.05) var follow_ratio: float = 1.0
@export_range(0, 100, 5) var follow_distance: int = 20
@export_range(0, 100, 5) var follow_angle: int = 45


@export_group("Actions")
@export var actions: Array[ActionCommand] = []
