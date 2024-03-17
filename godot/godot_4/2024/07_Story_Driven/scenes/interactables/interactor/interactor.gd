class_name Interactor extends Area2D

var current_area: Interactable


func _ready() -> void:
	area_entered.connect(on_enter)
	area_exited.connect(on_exit)


func interact() -> void:
	if current_area:
		current_area.interacted.emit()


func on_enter(area: Area2D) -> void:
	if not area is Interactable: return
	current_area = area
	area.grab_focus()


func on_exit(area: Area2D) -> void:
	if not area is Interactable: return
	current_area = null
	area.release_focus()
