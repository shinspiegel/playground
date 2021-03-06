extends BaseState

export(NodePath) var state_after_hit_path

var state_after: Node2D


func _ready() -> void:
	setup_nodes()


func enter() -> void:
	if target is Enemy:
		target.change_animation(name)
		target.animation_player.connect("animation_finished", self, "on_animation_finished")
		target.is_flip_active = false


func exit() -> void:
	if target is Enemy:
		target.animation_player.disconnect("animation_finished", self, "on_animation_finished")
		target.is_flip_active = true


func process(delta: float) -> void:
	if target is Enemy:
		target.apply_gravity(delta)
		target.apply_horizontal()


func receive_message(id: String, message) -> void:
	if target is Enemy:
		match id:
			"damage_hit_box":
				if message is HitBox:
					var direction = message.global_position.x - target.global_position.x

					if direction < 0:
						direction = 1
					elif direction > 0:
						direction = -1
					else:
						direction = 0

					target.apply_horizontal(direction, message.damage.power_x)
					target.apply_jump(message.damage.power_y)
					target.hurt(message.damage.amount)


## SIGNAL METHODS


func on_animation_finished(animation_name: String) -> void:
	if target is Enemy:
		if animation_name == name:
			if state_after == null:
				target.state_manager.change_state(target.state_manager.get_last_state())
			else:
				target.state_manager.change_state(state_after.name)


## SETUP METHODS


func setup_nodes() -> void:
	state_after = get_node(state_after_hit_path)
