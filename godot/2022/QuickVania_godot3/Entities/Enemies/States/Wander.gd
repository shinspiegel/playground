extends BaseState

export(NodePath) var front_ray_path
export(NodePath) var ground_ray_path
export(NodePath) var state_after_collide_wall_path

var front_ray_cast: RayCast2D
var ground_ray_cast: RayCast2D
var state_after_collide: Node2D
var direction: int


func _ready() -> void:
	setup()


func enter() -> void:
	if target is Enemy:
		direction = target.flip_direction


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_gravity(delta)
		target.apply_horizontal(direction)

		if should_turn():
			direction *= -1
			target.apply_horizontal(direction)
			target.state_manager.change_state(state_after_collide.name)


func should_turn() -> bool:
	if front_ray_cast.is_colliding() or not ground_ray_cast.is_colliding():
		return true
	return false


## SIGNAL METHODS

## SETUP METHODS


func setup() -> void:
	front_ray_cast = get_node(front_ray_path)
	ground_ray_cast = get_node(ground_ray_path)
	state_after_collide = get_node(state_after_collide_wall_path)
