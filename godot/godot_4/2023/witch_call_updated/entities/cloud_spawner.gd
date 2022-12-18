extends Node2D

@export var cloud_scene: PackedScene
@export var size = Vector2i.ZERO
@export var min_amount: int = 1
@export var max_amount: int = 5

@onready var delay: Timer = $Delay


func _ready() -> void:
	get_tree().root.size_changed.connect(size_changed)
	delay.timeout.connect(spawn_clouds)
	size_changed()


func size_changed(): 
	size = DisplayServer.window_get_size(0)


func spawn_clouds():
	for n in randi_range(min_amount, max_amount):
		var layer = randi_range(0,3)
		var instance: Node2D = cloud_scene.instantiate()
		
		add_child(instance)
		instance.global_position.x = randi_range(0, size.x)
		
		if(not layer == 0):
			var amount = 1/float(layer)
			instance.scale.x -= amount
			instance.scale.y -= amount
			instance.modulate = Color(1,1,1,amount)
