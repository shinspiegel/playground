extends BaseState

@export var front_floor_path: NodePath
@export var front_wall_path: NodePath
@export var state_after_collide_path: NodePath

var direction = null
var front_floor_ray: RayCast2D
var front_wall_ray: RayCast2D
var state_after_collide: BaseState

func _ready() -> void:
	if not front_floor_path.is_empty() or not front_wall_path.is_empty():
		front_floor_ray = get_node(front_floor_path)
		front_wall_ray = get_node(front_wall_path)
	else:
		print_debug("ERROR:: Failed to connect raycasts")
	
	if not state_after_collide_path.is_empty():
		state_after_collide = get_node(state_after_collide_path)


func enter() -> void:
	if target is Character:
		target.change_animation(name)
		
		if direction == null: 
			direction = target.flip.direction


func process(delta:float) -> void:
	if target is Character:
		if should_turn():
			direction *= -1
		
		target.apply_gravity(delta)
		target.apply_horizontal(direction)


func should_turn() -> bool:
	if front_wall_ray.is_colliding() or not front_floor_ray.is_colliding():
		return true
	return false
