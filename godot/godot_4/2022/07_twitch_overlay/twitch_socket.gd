class_name TwitchSocket extends Node

signal receved_message_from(from, text)
signal package_received(package)
signal connecction_authed()
signal connection_started()
signal connection_closed()

@export var enabled: bool = true
@export var auth_string: String = ""
@export var user_name: String = "Shin_Automato"
@export var channel_name: String = "#ShinSpiegel"
@export var irc_twitch_url: String = "wss://irc-ws.chat.twitch.tv:443"

var socket: WebSocketPeer = WebSocketPeer.new()
var is_auth: bool = false
var state = null
var regex = RegEx.new()


func _ready():
	if enabled:
		socket.connect_to_url(irc_twitch_url)
		regex.compile(":(.*)\\!.*@.*\\.tmi\\.twitch\\.tv (.*) #(.*) :(.*)")


func _process(_delta: float):
	if enabled:
		socket.poll()
		state = socket.get_ready_state()
		
		if not is_auth:
			auth()
		
		receive_packages()
		
		state = null


func receive_packages() -> void:
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var package = socket.get_packet().get_string_from_utf8()
			package_received.emit(package)
			parse_package(package)
	
	elif state == WebSocketPeer.STATE_CLOSING:
		print_debug("ERROR:: Closing socket")
		pass
	
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print_debug("ERROR:: WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false)


func parse_package(package: String) -> void:
	print("INFO:: ", package)
	var list = regex.search_all(package)
	
	for block in list:
		var values = block.get_strings()
		
		var message_user = values[1]
		var channel = values[3]
		var message_text = values[4]
		
		receved_message_from.emit(message_user, message_text)


func auth() -> void:
	if state == WebSocketPeer.STATE_OPEN:
		socket.send_text("PASS %s \n" % [auth_string])
		socket.send_text("NICK %s \n" % [user_name])
		socket.send_text("JOIN %s \n" % [channel_name])
		connecction_authed.emit()
		
		is_auth = true
