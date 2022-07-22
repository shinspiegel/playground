extends BaseState

export(NodePath) var timer_path
export(NodePath) var next_state

var timer: Timer


func _ready() -> void:
	setup_nodes()


func enter() -> void:
	if target is Enemy:
		target.change_animation(name)
		timer.start()


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_gravity(delta)
		target.apply_horizontal()


## SIGNAL METHODS


func on_timeout() -> void:
	print("Timeout")
	if target is Enemy:
		target.state_manager.change_state("Wander")


## SETUP METHODS


func setup_nodes() -> void:
	if not get_node(timer_path) == null:
		timer = get_node(timer_path)

		var con = timer.connect("timeout", self, "on_timeout")
		if not con == OK:
			print_debug("INFO:: Failed to connect hurt [%s]" % [name])
