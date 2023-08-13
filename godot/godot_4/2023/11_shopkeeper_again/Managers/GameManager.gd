extends Node

signal inventory_opened()
signal inventory_closed()


func open_inventory() -> void:
	inventory_opened.emit()


func close_inventory() -> void:
	inventory_closed.emit()
