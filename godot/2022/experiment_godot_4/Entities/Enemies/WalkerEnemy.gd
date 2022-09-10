extends Enemy

@onready var idle_timer: Timer = $Timers/IdleLimitTime
@onready var wander_timer: Timer = $Timers/WanderTime
@onready var front_floor_ray: RayCast2D = $Sensors/FrontFloor
@onready var front_wall_ray: RayCast2D = $Sensors/FrontWall 


func _ready() -> void:
	super()
	idle_timer.timeout.connect(func(): change_state("Wander"))
	wander_timer.timeout.connect(func(): change_state("Idle"))


func check_input() -> void:
	pass


func check_change_state() -> void:
	var current_state = state_manager.current_state.name
	
	if current_state == "Idle":
		pass
	
	if current_state == "Wander":
		if is_raycast_colliding():
			change_state("Idle") 


func is_raycast_colliding() -> bool:
	if not front_floor_ray.is_colliding() or front_wall_ray.is_colliding():
		return true
	return false
