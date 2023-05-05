class_name Interactor extends Area3D

@export var current_interactable: Interactable = null
@export var interactable_list: Array[Interactable] = []


func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exit)


func _process(delta: float) -> void:
	if interactable_list.size() <= 0:
		current_interactable = null
		
	elif interactable_list.size() == 1:
		current_interactable = interactable_list[0]
		current_interactable.grab_focus()
	else:
		get_closest_from_list()


func interact_on_current() -> void:
	if not current_interactable == null:
		current_interactable.interact()

func get_closest_from_list() -> void:
	var closest_one = interactable_list[0]
	var distance = global_transform.origin.distance_to(closest_one.global_transform.origin)
	
	for interactable in interactable_list:
		var interactable_distance = global_transform.origin.distance_to(interactable.global_transform.origin)
		if interactable_distance < distance:
			distance = interactable_distance
			closest_one = interactable
	
	if not closest_one == current_interactable:
		if not current_interactable == null: 
			current_interactable.drop_focus()
		current_interactable = closest_one
		current_interactable.grab_focus()


func on_area_entered(area: Area3D) -> void:
	if area is Interactable:
		interactable_list.push_back(area)


func on_area_exit(area: Area3D) -> void:
	if area is Interactable:
		var index = interactable_list.find(area)
		
		if index >= 0:
			var dropped = interactable_list.pop_at(index)
			dropped.drop_focus()
