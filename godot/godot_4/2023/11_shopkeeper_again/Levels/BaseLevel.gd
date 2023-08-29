class_name BaseLevel extends Node2D

@export var player: Player

@onready var sorted_object: Node2D = $SortedObject
@onready var background: Control = $Overlay/Background


func _ready() -> void:
	background.hide()
	GameManager.inventory_opened.connect(on_inventory_opened)
	GameManager.inventory_closed.connect(on_inventory_closed)
	GameManager.item_spawned.connect(on_item_spawn)


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
	var node = scene.instantiate()
	sorted_object.add_child(node)
	
	node.global_position = pos
	
	if node is DropItem:
		node.set_item(item)
	
	if node is ExplosiveItem:
		node.set_item(item)
	
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(
		node, 
		"global_position", 
		Vector2(pos.x + randf_range(-20, 20), pos.y + randf_range(-20, 20)), 
		0.3,
	)
	tween.play()

