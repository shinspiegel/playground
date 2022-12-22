extends Node2D

@export var cloud_scene: PackedScene
@export var min_amount: int = 1
@export var max_amount: int = 5

@onready var delay: Timer = $Delay

func _ready() -> void:
	delay.timeout.connect(on_time_out)


func on_time_out() -> void:
	for n in randi_range(min_amount, max_amount):
		spawn_cloud()


func spawn_cloud():
	var instance: Node2D = cloud_scene.instantiate()
	var pos_x = randi_range(0, ProjectSettings.get_setting("display/window/size/viewport_width"))
	add_child(instance)
	instance.global_position.x = pos_x

