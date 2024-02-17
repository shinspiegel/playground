class_name ActorPanel extends Control

@onready var action_container: BoxContainer = %ActionContainer


func _ready() -> void:
	BattleManager.turn_started.connect(on_turn_started)
	BattleManager.turn_ended.connect(on_turn_ended)
	hide()


func on_turn_started() -> void:
	var actor := BattleManager.current_actor

	if actor is PlayerActor:
		__create_container_butttons()
		global_position = actor.get_cursor_position()
		action_container.get_child(0).grab_focus()
		show()


func on_turn_ended() -> void:
	for node in action_container.get_children():
		node.pressed.disconnect(on_button_press)
		node.queue_free()

	hide()


func on_button_press(action: String) -> void:
	BattleManager.select_action(action)


func __create_container_butttons() -> void:
	var list_options: Array[String] = [
		"Shoot",
		"Reload",
		"Run",
	]

	for option in list_options:
		var btn := Button.new()
		btn.text = option
		btn.pressed.connect(on_button_press.bind(option))
		action_container.add_child(btn)

	await get_tree().create_timer(0.1).timeout
	action_container.get_child(0).grab_focus()

