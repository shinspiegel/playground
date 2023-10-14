class_name BaseLevel extends Node2D

const START_AREA_INDEX: int = 0

@export var wall_col_damage: Damage
@export var first_area_offset: Vector2 = Vector2.ZERO
@export var level_areas_list: Array[PackedScene]
@export var player2: Player
@export var game_camera: GameCamera
@export var wall_damage_colddown: Timer
@export var map_areas: Node2D

var __previous_area: LevelArea
var __current_area_index: int = 0


func _ready() -> void:
	__current_area_index = START_AREA_INDEX
	
	GameManager.created_node.connect(on_node_created)
	GameManager.spawned_damage.connect(on_damage_spawn)
	PlayerData.health_zeroed.connect(on_player_die)
	
	player2.set_camera(game_camera)
	player2.collided_with_wall.connect(on_player_collide_wall)
	
	__load_next_area()


func _physics_process(delta: float) -> void:
	__apply_speed_map_areas(delta)


func on_player_die() -> void:
	SceneManager.change_scene("game_over")

 
func on_node_created(scene: PackedScene, pos: Vector2) -> void:
	var node: Node2D = scene.instantiate()
	map_areas.add_child(node)
	node.global_position = pos


func on_damage_spawn(damage: Damage, pos: Vector2, scene: PackedScene) -> void:
	var node: DamageNumber = scene.instantiate()
	node.damage = damage
	map_areas.add_child(node)
	node.global_position = pos


func on_player_collide_wall() -> void:
	if wall_damage_colddown.time_left <= 0.0:
		player2.on_damage_receive(wall_col_damage)
		wall_damage_colddown.start()


func __load_next_area() -> void:
	if __current_area_index < level_areas_list.size():
		var area: LevelArea = level_areas_list[__current_area_index].instantiate()
		
		area.load_next.connect(__load_next_area)
		
		map_areas.add_child(area)
		
		if not __previous_area:
			area.global_position = first_area_offset - area.mark_start.global_position
		else:
			area.global_position = __previous_area.mark_end.global_position - area.mark_start.global_position
		
		__current_area_index += 1 
		__previous_area = area


func __apply_speed_map_areas(delta: float) -> void:
	for node in map_areas.get_children():
		if node is Node2D: 
			node.global_position.x -= PlayerData.get_horizontal_speed(delta)
