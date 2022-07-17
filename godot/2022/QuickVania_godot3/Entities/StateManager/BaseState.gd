class_name BaseState extends Node2D

export var debug: bool = false

var target = null


func _ready() -> void:
	if debug:
		print_debug("INFO:: State ready [%s]" % [name])


func enter() -> void:
	if debug:
		print_debug("INFO:: State entered [%s]" % [name])


func exit() -> void:
	if debug:
		print_debug("INFO:: State exited [%s]" % [name])


func process(delta: float) -> void:
	if debug:
		print_debug("INFO:: State process [%s] on delta [%s]" % [name, delta])


func check_change_state() -> void:
	if debug:
		print_debug("INFO:: Check if should change state in [%s]" % [name])
