class_name CutScene extends Node2D

export(Array, NodePath) var actor_list = []
export(NodePath) var tween_path

signal cut_scene_steped
signal key_pressed(key)

var tweeen
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


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action(KeysMap.ATTACK):
		emit_signal("key_pressed", KeysMap.ATTACK)

	if event.is_action(KeysMap.CANCEL):
		emit_signal("key_pressed", KeysMap.CANCEL)


func move_actor(actor: Node2D, direction: Vector2, duration: float = 1.0) -> void:
	var origin = actor.global_position
	var destination = origin + direction

	tweeen.interpolate_property(
		actor, "global_position", origin, destination, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tweeen.start()
	yield(tweeen, "tween_all_completed")
	emit_signal("cut_scene_steped")


func wait_time(duration: float = 1.0) -> void:
	yield(get_tree().create_timer(duration), "timeout")
	emit_signal("cut_scene_steped")


func speak(actor: Node2D, message: String, voice: String = "male_voice") -> void:
	Manager.bubble.display_message_at(message, actor.global_position, voice)
	emit_signal("cut_scene_steped")


func setup() -> void:
	tweeen = get_node(tween_path)

	for actor_path in actor_list:
		actors.append(get_node(actor_path))
