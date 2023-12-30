extends Node2D

@export var party_data: PartyData


func prepare_party_nodes() -> void:
	party_data.prepare_party_nodes()


func get_leader() -> PlayerActor:
	return party_data.get_leader()


func get_party() -> Array[PlayerActor]:
	return party_data.get_party()


func set_camera_for_leader() -> void:
	party_data.set_camera_for_leader()

