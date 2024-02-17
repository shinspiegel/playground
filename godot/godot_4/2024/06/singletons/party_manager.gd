extends Node

const PLAYER_ACTOR = preload("res://scenes/actors/player_actor.tscn")

var party: Array[PlayerActor] = []


func _ready() -> void:
	var player = PLAYER_ACTOR.instantiate()
	party.append(player)


func get_leader() -> PlayerActor:
	return party.front()


func party_size() -> int:
	return party.size()


func at(index: int) -> PlayerActor:
	return party[index]
