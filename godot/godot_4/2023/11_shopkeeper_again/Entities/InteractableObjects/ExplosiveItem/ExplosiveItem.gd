class_name ExplosiveItem extends InteractableObject

@export_group("Explosive Item")
@export var item: InventoryBomb

@onready var timer: Timer = $Timer
@onready var explosion_area: Node2D = $ExplosionArea


func _ready() -> void:
	super._ready()
	timer.timeout.connect(on_timeout)


func _on_interact() -> void:
	PlayerData.add_to_inventory(item)
	queue_free()


func set_item(value: InventoryBomb) -> void:
	item = value
	sprite_2d.texture = value.icon
	timer.start(value.explosive_time)
	__apply_explosion_area_effect()


func on_timeout() -> void:
	GameManager.spawn_explosion(item, global_position)
	queue_free()


func __apply_explosion_area_effect() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(
		explosion_area, 
		"scale", 
		Vector2(item.explosive_area, item.explosive_area), 
		item.explosive_time
	)
	tween.play()
