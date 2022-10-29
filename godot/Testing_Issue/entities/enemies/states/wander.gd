extends BaseState

var direction: int = 1

func enter() -> void:
	if target is Enemy:
		target.change_animation(name)
		direction = target.flip.direction


func process(delta:float) -> void:
	if target is Enemy:
		if target.has_method("is_raycast_colliding"):
			if target.is_raycast_colliding():
				direction *= -1
		else:
			print_debug("WARN:: Missing method on enemy.")
		
		target.apply_gravity(delta)
		target.apply_horizontal(direction)
