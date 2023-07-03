class_name TwitchHelper extends Node

@export var enabled: bool = true

@onready var http_request: HTTPRequest = $HTTPRequest


func _ready() -> void:
	if enabled:
		subscribe_to_events()


func subscribe_to_events() -> void:
	http_request.request(
		"https://api.twitch.tv/helix/eventsub/subscriptions",
		[
			"Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx",
			"Client-Id: wbmytr93xzw8zbg0p1izqyzzc5mbiz",
			"Content-Type: application/json"
		],
		true, 
		HTTPClient.METHOD_POST,
		JSON.stringify({
			"type": "channel.follow",
			"version":"1",
			"condition": {
				"broadcaster_user_id":"1234"
			},
			"transport": {
				"method":"webhook",
				"callback":"https://example.com/callback",
				"secret":"s3cre77890ab"
			}
		})
	)


func on_request_complete(result: int, code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("Completed")
	if not result == 0:
		print_debug("ERROR:: Failed to read the request")
		return 
	
	if code >= 200 and code <= 299:
		var body_string = body.get_string_from_utf8()
		var data = JSON.parse_string(body_string)
		var something = true
