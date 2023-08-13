extends Node

signal started()
signal ended()


func init_craft() -> void:
	started.emit()


func cancel_craft() -> void:
	ended.emit()
