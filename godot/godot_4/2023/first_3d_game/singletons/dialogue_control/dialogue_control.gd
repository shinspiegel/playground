extends CanvasLayer

@export var dialogue: Dialogue
@onready var player_input: PlayerInput = $PlayerInput


func _ready() -> void:
	player_input.next_dialogue.connect(play_next_message)


func load_dialog(d: Dialogue) -> void:
	dialogue = d


func play_next_message() -> void: 
	if not dialogue == null: 
		var message = dialogue.get_message()
		if message:
			print(message.text)
		else:
			dialogue = null
