class_name Interactor extends Area2D

@export var is_active: bool = true

var current_area: Interactable


func _ready() -> void:
	area_entered.connect(on_enter)
	area_exited.connect(on_exit)


func _physics_process(_delta: float) -> void:
	if current_area and is_active:
		__calculate_closest_one()


func interact() -> void:
	if not is_active:
		return

	if current_area:
		current_area.interacted.emit()


func on_enter(area: Area2D) -> void:
	if not is_active:
		return

	if not area is Interactable:
		return

	if current_area == null:
		current_area = area
		current_area.grab_focus()
	else:
		__calculate_closest_one()


func on_exit(area: Area2D) -> void:
	if not is_active:
		return

	if not area is Interactable: return

	if area == current_area:
		current_area.release_focus()
		current_area = null


func __calculate_closest_one() -> void:
	var list := get_overlapping_areas()

	if list.size() < 2:
		return

	var next: Interactable

	if not current_area == null:
		next = current_area

	var short := current_area.global_position.distance_to(global_position)

	for area in list:
		if area is Interactable and short > area.global_position.distance_to(global_position):
			short = area.global_position.distance_to(global_position)
			next = area

	if not next == current_area:
		current_area.release_focus()
		current_area = next
		current_area.grab_focus()

