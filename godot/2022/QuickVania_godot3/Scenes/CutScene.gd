class_name CutScene extends Node2D

export(Array, NodePath) var actor_list = []
export(NodePath) var tween_path
export(NodePath) var camera_path

signal step_ended
signal actor_moved
signal tween_ended
signal wait_ended
signal message_ended
signal key_pressed(key)

var tweeen: Tween
var camera: Camera2D
var actors = []
var started = false


func play_scene() -> void:
	pass


func _ready() -> void:
	setup()


func _process(_delta: float) -> void:
	if not started:
		started = true
		play_scene()

	if Input.is_action_just_pressed(KeysMap.ATTACK):
		emit_signal("key_pressed", KeysMap.ATTACK)

	if Input.is_action_just_pressed(KeysMap.CANCEL):
		emit_signal("key_pressed", KeysMap.CANCEL)


func move_actor(actor: Node2D, direction: Vector2, duration: float = 1.0) -> void:
	var origin = actor.global_position
	var destination = origin + direction

	tweeen.interpolate_property(
		actor, "global_position", origin, destination, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tweeen.start()
	yield(tweeen, "tween_all_completed")
	emit_signal("step_ended")
	emit_signal("actor_moved")


func set_move_actor(actor: Node2D, direction: Vector2, duration: float = 1.0) -> void:
	var origin = actor.global_position
	var destination = origin + direction

	tweeen.interpolate_property(
		actor, "global_position", origin, destination, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)


func apply_tween() -> void:
	tweeen.start()
	yield(tweeen, "tween_all_completed")
	emit_signal("step_ended")
	emit_signal("tween_ended")


func wait_time(duration: float = 1.0) -> void:
	yield(get_tree().create_timer(duration), "timeout")
	emit_signal("step_ended")
	emit_signal("wait_ended")


func speak_for(
	actor: Node2D, message: String, voice: String = "male_voice", position_adjustment: Vector2 = Vector2(0, -40)
) -> void:
	var bubble = Manager.bubble.displa_wait_message_at(message, actor.global_position + position_adjustment, voice)
	bubble.connect("finished", self, "on_message_finished")


func move_camera(position: Vector2) -> void:
	camera.global_position = position


func zoom_camera(amount: float, duration: float = 1.0) -> void:
	amount = clamp(amount, 0.1, 3)
	var origin = camera.zoom
	var final = Vector2(amount, amount)

	tweeen.interpolate_property(camera, "zoom", origin, final, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)


## OVERRIDE CLASS METHODS

## SIGNAL METHODS


func on_message_finished() -> void:
	emit_signal("step_ended")
	emit_signal("message_ended")


## SETUP METHODS


func setup() -> void:
	tweeen = get_node(tween_path)
	camera = get_node(camera_path)

	for actor_path in actor_list:
		actors.append(get_node(actor_path))
