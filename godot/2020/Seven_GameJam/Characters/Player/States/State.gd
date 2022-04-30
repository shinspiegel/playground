extends Node2D
class_name BaseState

# warning-ignore:unused_signal
signal finished(next_state_name)

var character
var animationPlayer: AnimationPlayer

func _ready() -> void:
	character = get_owner()
	animationPlayer = get_node("../../AnimationPlayer")


func enter():
	animationPlayer.play(self.name)
	pass


func exit():
	pass


# warning-ignore:unused_argument
func update_state(delta : float):
	pass


# warning-ignore:unused_argument
func handle_input(event : String):
	pass


# warning-ignore:unused_argument
func on_animation_finished(animation: String):
	pass
