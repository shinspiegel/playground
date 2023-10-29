class_name PlayerAnimation extends AnimationPlayer


func change_to(anim: String) -> void:
	if not current_animation == anim:
		play(anim)


func idle() -> void: change_to("idle")
func move() -> void: change_to("move")
func landing() -> void: change_to("landing")
func jump_up() -> void: change_to("jump_up")
func jump_top() -> void:change_to("jump_top")
func jump_down() -> void: change_to("jump_down")
