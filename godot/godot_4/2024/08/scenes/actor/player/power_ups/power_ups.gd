class_name PowerUps extends Resource

@export var ranged_enabled: bool = false
@export var create_block_enabled: bool = false
@export var forward_dash: bool = false

@export_group("Ranged Attack upgrades", "ranged_")
@export var ranged_extra_range: bool = false
@export var ranged_extra_damage: bool = false
@export var ranged_multiple_projectile: bool = false

@export_group("Create Block upgrades", "block_")
@export var block_extra_life: bool = false
@export var block_deas_damage: bool = false
@export var block_additional: bool = false

@export_group("Forward Dash upgrades", "forward_")
@export var forward_invulnerable: bool = false
@export var forward_deal_damage: bool = false
@export var forward_reduced_colddown: bool = false

var blocks: Array[Node2D] = []
var max_blocks: int = 1
