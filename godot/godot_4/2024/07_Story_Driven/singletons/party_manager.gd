extends Node

const PLAYER_ACTOR = preload("res://scenes/actors/player_actor.tscn")

const PARTY_LIST = [
	preload("res://scenes/actors/party_data/hero_1.tres"),
	# preload("res://scenes/actors/party_data/hero_2.tres"),
	# preload("res://scenes/actors/party_data/hero_3.tres"),
]

var party: Array[PlayerActor] = []


func _ready() -> void:
	__prepare_party()


func get_leader() -> PlayerActor:
	return party.front()


func party_size() -> int:
	return party.size()


func at(index: int) -> PlayerActor:
	return party[index]


func __prepare_party() -> void:
	for data in PARTY_LIST:
		var player: PlayerActor = PLAYER_ACTOR.instantiate()
		player.actor_data = data
		party.append(player)


func enable_leader_camera() -> void:
	get_leader().enable_camera()


func disabled_leader_camera() -> void:
	get_leader().disable_camera()
