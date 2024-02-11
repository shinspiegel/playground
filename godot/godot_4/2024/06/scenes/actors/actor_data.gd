class_name ActorData extends Resource


@export_group("World Data")
@export var speed: int = 500
@export var friction: float = 10


@export_group("Battle Data", "battle_")
@export var battle_max_hp: int = 10
@export var battle_attack: int = 5
@export var battle_defense: int = 2


@export_group("Texture")
@export var base_texture: Texture2D
@export var body_texture: Texture2D
@export var head_texture: Texture2D

