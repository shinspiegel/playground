extends BaseState


func enter() -> void:
	if target is Enemy:
		target.change_animation(name)


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_gravity(delta)
		target.velocity.x = 0

## SIGNAL METHODS

## SETUP METHODS
