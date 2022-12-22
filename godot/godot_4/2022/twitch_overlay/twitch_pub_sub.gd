class_name TwitchPubSub extends Node

@export var url: String = "wss://pubsub-edge.twitch.tv"

@onready var http: HTTPRequest = $HTTPRequest

var socket: WebSocketPeer = WebSocketPeer.new()
var socket_state: WebSocketPeer.State

func _ready():
	http.request_completed.connect(request_complete)
#	socket_state = null
#	socket.connect_to_url(url)
	twitch_auth()


#func _process(delta):
#	socket.poll()
#	socket_state = socket.get_ready_state()
#
#	if socket_state == WebSocketPeer.STATE_OPEN:
#		while socket.get_available_packet_count():
#			print("Packet: ", socket.get_packet())
#
#	elif socket_state == WebSocketPeer.STATE_CLOSING:
#		print("Closing state")
#
#	elif socket_state == WebSocketPeer.STATE_CLOSED:
#		var code = socket.get_close_code()
#		var reason = socket.get_close_reason()
#		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])


func twitch_auth() -> void:
	var base_url = "https://id.twitch.tv/oauth2/authorize"
	var response = "response_type=token"
	var client_id = "client_id=hof5gwx0su6owfnys0yan9c87zr6t"
	var redirect_url = "redirect_uri=http://localhost:3000"
	var scope = "scope=channel%3Amanage%3Apolls+channel%3Aread%3Apolls"
	var state = "state=c3ab8aa609ea11e793ae92361f002671"
	
	var url = base_url+"?"+response+"&"+client_id+"&"+redirect_url+"&"+scope+"&"+state
	
	http.request(url)


func request_complete(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("result::        ", result)
	print("response_code:: ", response_code)
	print("headers::       ", headers.to_byte_array().get_string_from_utf8())
	print("body::          ", body.get_string_from_utf8())

