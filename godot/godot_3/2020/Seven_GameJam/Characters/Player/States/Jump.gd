extends BaseState

export(PackedScene) var JumpEffect

onready var coyoteTimer: Timer = $CoyoteTimer
onready var jumpEffectPosition: Position2D = $JumpEffectPosition

var jumping: bool = false


# warning-ignore:unused_argument
func update_state(delta : float):
	jump()
	
	if(character.motion.y > 0):
		emit_signal("finished", "Falling")
	
	if(Input.is_action_pressed("ui_left")): 
		character.input_vector = Vector2.LEFT
	
	elif(Input.is_action_pressed("ui_right")): 
		character.input_vector = Vector2.RIGHT
	
	else:
		character.input_vector = Vector2.ZERO


func jump():
	if !jumping:
		if character.is_on_floor() or coyoteTimer.time_left > 0:
			jumping = true
			Utils.instance_scene_on_main(JumpEffect, jumpEffectPosition.global_position)
			character.motion.y = -character.JUMP_FORCE
	elif character.can_consume_orb() and Input.is_action_just_pressed("button_main"):
			character.consume_obrs()
			Utils.instance_scene_on_main(JumpEffect, jumpEffectPosition.global_position)
			character.motion.y = -(character.JUMP_FORCE * 0.75)

func handle_input(event : String):
	if event == "reload":
		emit_signal("finished", "SwordAttack")


func _on_StateMachine_state_changed(new_state: String) -> void:
	if new_state == "Falling":
			coyoteTimer.start()
	
	if new_state == "Idle" or new_state == "Move":
		if character.is_on_floor():
			jumping = false
