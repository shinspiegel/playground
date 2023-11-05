class_name PlayerAnimation extends AnimationPlayer

signal hurt_ended()
signal attack_ended()

func _ready() -> void:
	animation_finished.connect(on_animation_finished)


func change_to(anim: String) -> void:
	if not current_animation == anim:
		play(anim)


func idle() -> void: change_to("idle")
func move() -> void: change_to("move")
func landing() -> void: change_to("landing")
func jump_up() -> void: change_to("jump_up")
func jump_top() -> void:change_to("jump_top")
func jump_down() -> void: change_to("jump_down")
func hurt() -> void: change_to("hurt")
func attack() -> void: change_to("jab")


func reset_attack() -> void: 
	if current_animation == "jab":
		seek(0.0, true)


func on_animation_finished(anim: String) -> void:
	if anim == "hurt":
		hurt_ended.emit()
	
	if anim == "jab":
		attack_ended.emit()
