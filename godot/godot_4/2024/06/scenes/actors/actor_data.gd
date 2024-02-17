class_name ActorData extends Resource


@export_group("World Data")
@export var speed: int = 500
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
@export var follow_min_distance: int = 120
@export var follow_ratio: float = 0.9
@export var follow_distance: int = 50
@export var follow_angle: int = 45

@export_group("Actions")
@export var actions: Array[ActionCommand] = []
