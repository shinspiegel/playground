class_name PathFollower extends Path3D

@export_range(0, 5, 0.1) var duration: float = 2.0
@export_range(0, 5, 0.1) var wait_time: float = 1.0
@export_range(0, 1, 0.05) var delay_time: float = 0.0

@onready var follow_point: PathFollow3D = $PathFollow3D
@onready var colddown: Timer = $Colddown

var amount = 1


func _ready() -> void:
	colddown.timeout.connect(on_timeout)
	_initial_start()
	_move_children_to_path()


func _move_children_to_path() -> void:
	for index in range(2, get_child_count()):
		var child: Node3D = get_child(index)
		remove_child(child)
		follow_point.add_child(child)


func _initial_start() -> void:
	if delay_time > 0.0:
		colddown.start(delay_time)
	else: 
		tween_to()


func tween_to() -> void:
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(follow_point, "progress_ratio", amount, duration)
	tween.finished.connect(on_tween_finished)


func reverse_amount() -> void:
	if amount == 1:
		amount = 0
	else:
		amount = 1


func on_timeout() -> void:
	tween_to()


func on_tween_finished() -> void:
	reverse_amount()
	colddown.start(wait_time)

