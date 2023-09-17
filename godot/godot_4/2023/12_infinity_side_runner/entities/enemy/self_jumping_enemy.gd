extends BaseEnemy

@export_range(0.0, 5.0, 0.1) var jump_colddown: float = 1.0
@export var jump_force: float = 10.0
@export_range(0.0, 2.0, 0.1) var jump_delay: float = 0.0

@onready var jump_colddown_timer: Timer = $JumpColddownTimer


func _ready() -> void:
	super._ready()
	jump_colddown_timer.timeout.connect(on_jump_colddown)
	jump_colddown_timer.start(jump_colddown + jump_delay)

func _physics_process(delta: float) -> void:
	if not is_active: return
	apply_gravity(delta)
	move_and_slide()


func on_jump_colddown() -> void:
	__jump()
	jump_colddown_timer.start(jump_colddown)


func __jump() -> void:
	velocity.y = jump_force * GameManager.MULTIPLIER * -1
