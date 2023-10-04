class_name PlayerPowerUp extends Resource

@export var icon: Texture2D
@export var power_up: String = ""
@export_multiline var description: String = ""
@export var cost: int = 0
@export var is_enabled: bool = true
@export var is_selected: bool = false

@export_group("Effects", "extra_")
@export var extra_health: int = 0
@export var extra_armor: int = 0
@export_range(-1.0, 1.0, 0.05) var extra_jump_power: float = 0.0
@export_range(-1.0, 1.0, 0.05) var extra_speed: float = 0.0
@export var extra_weapon: PackedScene
@export_enum("front", "top", "back") var extra_weapon_slot: String = "front"
@export var extra_effect: PackedScene
