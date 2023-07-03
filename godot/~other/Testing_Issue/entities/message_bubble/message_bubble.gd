class_name MessageBubble extends Node2D

@onready var rich_text: RichTextLabel = $Control/RichTextLabel
@onready var text_to_speech: TextToSpeech = $TextToSpeech

var regex = RegEx.new()
var voice: String = Constants.VOICES_NAME.default


func _ready() -> void:
	regex.compile("\\[\\/?[^\\]]*\\]")
	rich_text.set_visible_ratio(0)


func display() -> void:
	var tween: Tween = get_tree().create_tween()
	var duration: float = get_text_without_bb().length() * 0.03
	
	match voice:
		"hero_voice": 
			text_to_speech.speak_for_hero(get_text_without_bb())
		"vampire_voice":
			text_to_speech.speak_for_vampire(get_text_without_bb())
		_:
			text_to_speech.play_string_for(get_text_without_bb())
	
	tween.tween_property(rich_text, "visible_ratio", 1.0, duration)
	tween.chain().tween_interval(2)
	
	var out_duration: float = 0.5
	tween.tween_property(self, "modulate", Color(1,1,1,0), out_duration).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "position", Vector2(position.x, position.y - 8), out_duration).set_ease(Tween.EASE_OUT)
	tween.chain().tween_callback(func(): queue_free())


func add_text(message: String) -> void:
	rich_text.text = "[center]" + message + "[/center]"


func get_text_without_bb() -> String:
	var copy_text = rich_text.text
	var list = regex.search_all(copy_text)
	
	for bb_found in list:
		var bb_code = bb_found.get_string()
		copy_text = copy_text.replace(bb_code, "")
	
	return copy_text
