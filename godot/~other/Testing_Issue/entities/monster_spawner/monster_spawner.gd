extends Marker2D

@export var mosnter_scene: PackedScene

func _ready():
	var monster: Node2D = mosnter_scene.instantiate()
	get_parent().call_deferred("add_child", monster)
	monster.set_deferred("global_position", global_position)
