extends Node2D

func _process(delta):
	if $RayCast2D.is_colliding() && $Timer.is_stopped():
		fire()

func fire():
	$Timer.start()
	var lightning = load("res://Enemies/Lightning.tscn").instance()
	lightning.global_position = global_position
	get_parent().add_child(lightning)