extends BaseState

@export var enemy: BaseEnemy
@export var inputs: EnemyInput
@export var animation_player: AnimationPlayer
@export var floor_ray: RayCast2D
@export var wall_ray: RayCast2D


func enter() -> void:
	animation_player.play(name)
	
	var dir := 1
	if not enemy.facing_right:
		dir *= -1
	if not floor_ray.is_colliding():
		dir *= -1
	inputs.set_direction(dir)


func exit() -> void:
	inputs.reset()


func physics_process(delta: float) -> void:
	enemy.apply_gravity(delta)
	enemy.apply_horizontal_force()
	enemy.move_and_slide()
	
	if not floor_ray.is_colliding():
		state_ended.emit("idle")
		return
	
	if wall_ray.is_colliding():
		if inputs.last_direction < 0:
			inputs.set_direction(1)
		else:
			inputs.set_direction(-1)
		
		state_ended.emit("idle")
		return 
