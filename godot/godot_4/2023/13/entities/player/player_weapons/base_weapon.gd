class_name BaseWeapon extends Node2D

enum AIM_TYPE {CLOSE, FAR}

@export var player: Player
@export var shoot_colddown: Timer
@export var anim_player: AnimationPlayer
@export var current_target: BaseEnemy

@export_group("Auto aim")
@export var aim_sprite: Node2D
@export var aim_type: AIM_TYPE = AIM_TYPE.CLOSE
@export var auto_target_area: Area2D
@export_range(0.05, 2.0, 0.05) var speed_to_aim: float = 0.2

var __enemies_map: Dictionary = {}


func _ready() -> void:
	if not auto_target_area == null:
		auto_target_area.body_entered.connect(on_body.bind(true))
		auto_target_area.body_exited.connect(on_body.bind(false))


func _physics_process(_delta: float) -> void:
	update_current_enemy()
	update_gun_angle()
	update_aim_sprite()


func shoot() -> void:
	print_debug("WARN::Should implement this method")


func update_current_enemy() -> void:
	if __enemies_map.size() > 0:
		match aim_type:
			AIM_TYPE.CLOSE: __get_close_enemy()
			AIM_TYPE.FAR: __get_far_enemy()
			_: print_debug("WARN::Something wrong on the auto-aim")
	else:
		current_target = null


func update_gun_angle() -> void:
	if current_target:
		var target_direction = global_position.direction_to(current_target.global_position)
		var target_angle = atan2(target_direction.y, target_direction.x)
		var ang_difference = fposmod(target_angle - rotation + PI, 2 * PI) - PI

		rotation += clamp(ang_difference, -speed_to_aim, speed_to_aim)
	else:
		var target = 0
		if player.facing_dir == -1: target = PI

		rotation = lerp_angle(rotation, target, speed_to_aim)



func update_aim_sprite() -> void:
	aim_sprite.global_rotation = 0

	if current_target:
		aim_sprite.global_position = lerp(aim_sprite.global_position, current_target.global_position, speed_to_aim)
		aim_sprite.modulate = lerp(aim_sprite.modulate, Color(1,1,1,1), speed_to_aim)
	else:
		aim_sprite.global_position = lerp(aim_sprite.global_position, global_position, speed_to_aim)
		aim_sprite.modulate = lerp(aim_sprite.modulate, Color(0,0,0,0), speed_to_aim)


func on_body(node: Node2D, append: bool) -> void:
	if node is BaseEnemy:
		if append:
			__enemies_map[node.name] = node
		else:
			__enemies_map.erase(node.name)


# Private Methods


func __get_far_enemy() -> void:
	var far_distance: float = -1

	for enemy in __enemies_map.values():
		if enemy is BaseEnemy:
			var dist = global_position.distance_to(enemy.global_position)

			if far_distance < 0:
				far_distance = dist
				current_target = enemy
			elif dist > far_distance:
				far_distance = dist
				current_target = enemy


func __get_close_enemy() -> void:
	var short_distance: float = -1.0

	for enemy in __enemies_map.values():
		if enemy is BaseEnemy:
			var dist = global_position.distance_to(enemy.global_position)

			if short_distance < 0:
				short_distance = dist
				current_target = enemy
			elif dist < short_distance:
				short_distance = dist
				current_target = enemy
