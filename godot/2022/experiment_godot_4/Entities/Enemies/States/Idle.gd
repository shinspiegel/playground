extends BaseState

@export var idle_timer_path: NodePath

var idle_timer: Timer

func _ready() -> void:
	if not idle_timer_path.is_empty():
		idle_timer = get_node(idle_timer_path)
	else:
		print_debug("ERROR: Failed to locate idle timer node")


func enter() -> void:
	if target is Character:
		target.change_animation(name)
		target.velocity = Vector2.ZERO
		idle_timer.start()


func process(delta: float) -> void:
	if target is Character:
		target.apply_gravity(delta)
