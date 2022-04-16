extends Node2D
class_name StateMachine

export(String) var InitialState = "Idle"
signal state_changed(new_state)
var current_state : BaseState = null


func _ready():
	for state_node in get_children():
		state_node.connect("finished", self, "_change_state")
	
	current_state = get_node("Idle")
	_change_state("Idle")


func _physics_process(delta):
	current_state.update_state(delta)


func _delegate_input(input : String):
	current_state.handle_input(input)


func _change_state(state_name: String):
	var update_state = get_node(state_name)
	
	if update_state != null:
		current_state.exit()
		current_state = update_state
		current_state.enter()
		emit_signal("state_changed", state_name)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	current_state.on_animation_finished(anim_name)


func _on_Character_die() -> void:
	_change_state("Die")


func _on_Character_take_hit() -> void:
	_change_state("Hit")
