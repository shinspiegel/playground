extends Node

const PLAYER_ACTOR = preload("res://scenes/actors/player_actor.tscn")

const HERO_1_DATA = preload("res://scenes/actors/party_data/hero_1.tres")
const HERO_2_DATA = preload("res://scenes/actors/party_data/hero_2.tres")
const HERO_3_DATA = preload("res://scenes/actors/party_data/hero_3.tres")

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
	for data in [HERO_1_DATA, HERO_2_DATA, HERO_3_DATA]:
		var player: PlayerActor = PLAYER_ACTOR.instantiate()
		player.actor_data = data
		party.append(player)
