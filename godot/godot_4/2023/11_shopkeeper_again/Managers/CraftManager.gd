extends Node

signal started()
signal ended()


func init_craft() -> void:
	print_debug(self)
	started.emit()


func cancel_craft() -> void:
	print_debug(self)
	ended.emit()
