class_name Interactor extends Area2D

var current_intractable: Interactable


func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)


func _process(_delta: float) -> void:
	if can_interact():
		__check_for_multiple_areas()


func can_interact() -> bool:
	if not current_intractable == null:
		return true
	return false


func interact_current() -> void:
	current_intractable.interact()


func on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		if current_intractable == null:
			current_intractable = area
			current_intractable.grab_focus()


func on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		if current_intractable == area:
			current_intractable.release_focus()
			current_intractable = null
			__check_grab_next(area)


func __check_for_multiple_areas() -> void:
	if get_overlapping_areas().size() == 1:
		return
	
	for area in get_overlapping_areas():
		if area is Interactable:
			if area == current_intractable:
				pass
			
			if __is_shorter(area):
				current_intractable.release_focus()
				current_intractable = area
				current_intractable.grab_focus()


func __check_grab_next(ignore: Area2D) -> void:
	if get_overlapping_areas().size() == 1:
		return
	
	var list = get_overlapping_areas()
	list.erase(ignore)
	
	for area in list:
		if area is Interactable:
			if not current_intractable:
				current_intractable = area
				current_intractable.grab_focus()
				pass
			
			if area == current_intractable:
				pass
			
			if __is_shorter(area):
				current_intractable.release_focus()
				current_intractable = area
				current_intractable.grab_focus()


func __is_shorter(area: Interactable) -> bool:
	var current_distance = global_position.distance_to(current_intractable.global_transform.origin)
	var area_distance = global_position.distance_to(area.global_transform.origin)
	
	if area_distance < current_distance:
		return true
	
	return false
