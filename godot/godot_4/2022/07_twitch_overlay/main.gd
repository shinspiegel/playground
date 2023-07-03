class_name Main extends Control


@onready var ts: TwitchSocket = $TwitchSocket


var is_trigger: bool = false
var rand_names: Array[String] = ["Shin", "Vodag", "Marting"]
var rand_messages: Array[String] = [
	"This is a fake message",
	"Another message but longer and bigger",
	"Short one",
	"This is a very long message that nobody should ever send a message this long, and in special someone that should not send it, please keep the messages short"
	]

func _ready():
	get_tree().get_root().set_transparent_background(true)
#	ts.package_received.connect(save_package_on_text)
#	ts.receved_message_from.connect(cc.add_chat_message)

func save_package_on_text(package) -> void:
	var path = "/Users/jeferson_leite_borges/Documents/save_game.txt"
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	file.seek_end()
	file.store_string(package)

#func _process(delta) -> void:
#	if not is_trigger:
#		is_trigger = true
#		rand_names.shuffle()
#		rand_messages.shuffle()
#
#		cc.add_chat_message(rand_names[0], rand_messages[0])
#		await get_tree().create_timer(0.5).timeout
#		is_trigger = false
#
#
