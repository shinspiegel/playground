class_name InventoryItem extends Resource

enum RARITY {common, uncommon, rare}

@export_group("Inventory Item")
@export var item_name: String
@export var icon: Texture2D
@export_enum("common", "uncommon", "rare") var rarity: int

@export_group("Spawn Variables", "spawn_")
@export var spawn_force: float = 100.0
@export var spawn_direction: Vector2 = Vector2.ZERO
@export var spawn_damp: float = 10.0
@export var spawn_physics_material: PhysicsMaterial = preload("res://Resources/InventoryItems/base_physics_material.tres")
