class_name Dialogue extends Resource

@export var linear_dialogue: Array[DialogueMessage] = []

var index: int = 0

## Will get the current message and move the head for the next message.
## Returns `null` if it's on the end of the list
func get_message() -> DialogueMessage:
	if index+1 > linear_dialogue.size():
		return null
	
	index += 1
	return linear_dialogue[index-1]
