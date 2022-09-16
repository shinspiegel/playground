extends "res://Scripts/Character.gd"

const FOV_TOLERANCE := 21
const MAX_DETECTION = 320
export (Color) var TriggerColor = Color(1, 0.1, 0.2)
var NeutralColor := Color(1,1,1)

onready var tree_root = get_tree().get_root() 
onready var Player = tree_root.get_child( tree_root.get_child_count()-1 ).get_node("Player")

func _process(delta):
	if Player_is_in_FOV_TOLERANCE() && Player_is_line_of_sight():
		$LightTorch.color = TriggerColor
	else:
		$LightTorch.color = NeutralColor

func Player_is_in_FOV_TOLERANCE() -> bool:
	var npc_facing = Vector2(1,0).rotated(global_rotation)
	var direction_to_player = (Player.position - global_position).normalized()
	
	if abs(direction_to_player.angle_to(npc_facing)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false

func Player_is_line_of_sight():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	var distance_to_player = Player.global_position.distance_to(global_position)
	var player_in_range = distance_to_player < MAX_DETECTION
	
	if LOS_obstacle.collider == Player && player_in_range:
		return true
	else:
		return false