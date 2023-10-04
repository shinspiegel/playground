extends BaseEnemy

@export_range(0.0, 5.0, 0.1) var jump_delay: float = 0.0
@export var jump_force: float = 8.0
@onready var jump_timer: Timer = $JumpTimer


func _ready() -> void:
	super._ready()
	jump_timer.timeout.connect(__jump)


func _physics_process(delta: float) -> void:
	if not is_active: return
	apply_gravity(delta)
	move_and_slide()
	apply_jump()


func apply_jump() -> void:
	if Input.is_action_just_pressed(PlayerData.JUMP_KEY) and is_on_floor():
		if jump_delay > 0.0:
			jump_timer.start(jump_delay)
		else:
			__jump()


func __jump() -> void:
	velocity.y = jump_force * GameManager.MULTIPLIER * -1
