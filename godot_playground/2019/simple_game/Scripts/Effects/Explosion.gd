extends Area2D

export (int, 1, 10) var DAMAGE := 1

func _ready():
	get_node("AnimatedSprite").play("Explosion")

func _process(delta):
	var Targets = get_overlapping_bodies()
	for Target in Targets:
		if Target.has_method("receive_damage"):
			Target.receive_damage(DAMAGE)

func _on_AnimatedSprite_animation_finished():
	queue_free()