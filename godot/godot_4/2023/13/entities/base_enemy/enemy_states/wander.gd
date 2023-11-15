extends BaseState

@export var enemy: BaseEnemy
@export var inputs: EnemyInput
@export var animation_player: AnimationPlayer
@export var floor_ray: RayCast2D
@export var wall_ray: RayCast2D
@export var player_detector: PlayerDetector

@export_group("State Change", "next_")
@export var next_not_floor: BaseState
@export var next_wall_collide: BaseState
@export var next_player_detected: BaseState


func enter() -> void:
	animation_player.play(name)
	player_detector.player_sighted.connect(on_player_sight)
	
	var dir := 1
	if not enemy.facing_right:
		dir *= -1
	if not floor_ray.is_colliding():
		dir *= -1
	inputs.set_direction(dir)


func exit() -> void:
	inputs.reset()
	player_detector.player_sighted.disconnect(on_player_sight)


func physics_process(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_horizontal_force()
	enemy.move_and_slide()
	
	if not floor_ray.is_colliding():
		state_ended.emit(next_not_floor.name)
		return
	
	if wall_ray.is_colliding():
		if inputs.last_direction < 0:
			inputs.set_direction(1)
		else:
			inputs.set_direction(-1)
		
		state_ended.emit(next_wall_collide.name)
		return 


func on_player_sight() -> void:
	state_ended.emit(next_player_detected.name)
