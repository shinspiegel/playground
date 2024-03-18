class_name Interactor extends Area2D

var current_area: Interactable


func _ready() -> void:
	area_entered.connect(on_enter)
	area_exited.connect(on_exit)


func _physics_process(_delta: float) -> void:
	if current_area:
		__calculate_closest_one()


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


func __calculate_closest_one() -> void:
	var list = get_overlapping_areas()
	var short = current_area.global_position.distance_to(global_position)
	
	for area in list:
		if area is Interactable:
			area.global_position.distance_to(global_position)

	pass
