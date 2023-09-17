extends BaseEnemy

@export_range(0.0, 10.0, 0.1) var jump_colddown: float = 5.0
@export var jump_force: float = 12.0
@export_range(0.0, 5.0, 0.1) var first_jump_delay: float = 0.0

@onready var jump_colddown_timer: Timer = $JumpColddownTimer


func _ready() -> void:
	super._ready()
	jump_colddown_timer.timeout.connect(on_jump_colddown)
	jump_colddown_timer.start(first_jump_delay)


func on_jump_colddown() -> void:
	__jump()
	jump_colddown_timer.start(jump_colddown)


func __jump() -> void:
	velocity.y = jump_force * GameManager.MULTIPLIER * -1
