extends CanvasLayer

signal dialogue_started(dialogue: DialogueList)
signal dialogue_ended(dialogue: DialogueList)

@export var dialogue: DialogueList

@onready var base_node: Control = %BaseNode
@onready var message: Label = %Message
@onready var char_name: Label = %CharName
@onready var profile: TextureRect = %Profile

var _index: int = 0


func _ready() -> void:
	_clean_message()


func start_dialogue(d: DialogueList) -> void:
	get_tree().paused = true
	dialogue = d
	base_node.visible = true
	_index = 0
	if not PlayerInput.interacted.is_connected(on_player_input):
		PlayerInput.interacted.connect(on_player_input)
	dialogue_started.emit(dialogue)
	on_player_input()


func _finish_dialogue() -> void:
	if not PlayerInput.interacted.is_connected(on_player_input):
		PlayerInput.interacted.disconnect(on_player_input)
	dialogue_ended.emit(dialogue)
	get_tree().paused = false


func on_player_input() -> void:
	if _has_next():
		var current = dialogue.list[_index]
		_set_message(current)
		_index += 1
	else:
		_clean_message()
		_finish_dialogue()


func _has_next() -> bool:
	return not dialogue == null and _index < dialogue.list.size()


func _set_message(msg: DialogueMessage) -> void:
	char_name.text = msg.character
	message.text = msg.message
	profile.texture = msg.icon


func _clean_message() -> void:
	base_node.visible = false
	char_name.text = ""
	message.text = ""
	profile.texture = null
