extends Character

@export var hit_points: int = 5

@onready var idle_timer: Timer = $Timers/IdleLimitTime
@onready var wander_timer: Timer = $Timers/WanderTime
@onready var front_floor_ray: RayCast2D = $Sensors/FrontFloor
@onready var front_wall_ray: RayCast2D = $Sensors/FrontWall 


func _ready() -> void:
	idle_timer.timeout.connect(func(): change_state("Wander"))
	wander_timer.timeout.connect(func(): change_state("Idle"))
	hurt_box.hit_received.connect(on_reaceive_damage)


func check_change_state() -> void:
	var current_state = state_manager.current_state.name
	
	if current_state == "Idle":
		pass
	
	if current_state == "Wander":
		if not front_floor_ray.is_colliding() or front_wall_ray.is_colliding():
			change_state("Idle")


func hurt(damage: int) -> void:
	if hit_points - damage <= 0:
		hit_points = 0
	else:
		hit_points -= damage


func on_reaceive_damage(hit: HitBox) -> void:
	hurt(hit.damage.amount)
	change_state("Hit")
	state_manager.send_message("hit", hit)

 
