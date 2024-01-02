class_name PartyData extends Resource

const HERO_1 = preload("res://hero_1.tscn")
const HERO_2 = preload("res://hero_2.tscn")


var party: Array[PlayerActor] = []


func _init() -> void:
	prepare_party_nodes()


func prepare_party_nodes() -> void:
	var hero_1 = __create_player_actor_instance(HERO_1)
	hero_1.name = hero_1.char_name
	if not hero_1 == null: party.append(hero_1)

	var hero_2 = __create_player_actor_instance(HERO_2)
	hero_2.name = hero_2.char_name
	if not hero_2 == null: party.append(hero_2)


func get_leader() -> PlayerActor:
	return party[0]


func get_party() -> Array[PlayerActor]:
	return party


func set_camera_for_leader() -> void:
	party[0].set_camera()


# Private


func __create_player_actor_instance(res: Resource) -> PlayerActor:
	if res is PackedScene:
		var instance = res.instantiate()

		if instance is PlayerActor:
			return instance

	print_debug("WARN:: Failed to load the resource [%s]" % [res])
	return null

