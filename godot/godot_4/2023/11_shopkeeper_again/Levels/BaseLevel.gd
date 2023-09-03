class_name BaseLevel extends Node2D

@export var player: Player

@onready var sorted_object: Node2D = $SortedObject
@onready var background: Control = $Overlay/Background
@onready var damage_numbers: Node2D = $DamageNumbers


func _ready() -> void:
	background.hide()
	GameManager.inventory_opened.connect(on_inventory_opened)
	GameManager.inventory_closed.connect(on_inventory_closed)
	GameManager.item_spawned.connect(on_item_spawn)
	GameManager.damage_spawned.connect(on_damage_spawn)


func pause_sorted() -> void:
	sorted_object.set_deferred("process_mode", PROCESS_MODE_DISABLED)


func unpause_sorted() -> void:
	sorted_object.set_deferred("process_mode", PROCESS_MODE_INHERIT)


func on_inventory_opened() -> void:
	pause_sorted()
	background.show()


func on_inventory_closed() -> void:
	background.hide()
	unpause_sorted()


func on_item_spawn(item: InventoryItem, pos: Vector2, scene: PackedScene) -> void:
	if GameManager.is_inventory_open: return
	
	var node = scene.instantiate()
	sorted_object.add_child(node)
	node.global_position = pos
	
	if node is InteractableObject:
		node.set_physics_material_override(item.spawn_physics_material)
		node.set_linear_damp(item.spawn_damp)
		node.apply_impulse(item.spawn_force * item.spawn_direction)
	
	if node is DropItem:
		node.set_item(item)
	
	if node is ExplosiveItem:
		node.set_item(item)
	
	if node is Explosion:
		node.set_item(item)


func on_damage_spawn(damage: Damage, pos: Vector2, scene: PackedScene) -> void:
	var node: DamageNumber = scene.instantiate()
	node.damage = damage
	node.global_position = pos
	damage_numbers.add_child(node)
