extends Node2D

const HERO_1 = preload("res://hero_1.tscn")
const HERO_2 = preload("res://hero_2.tscn")


@export var party: Array[PlayerActor]


func get_party() -> Array[PlayerActor]:
	var _party: Array[PlayerActor] = []

	var hero_1 = __create_instance_for(HERO_1)
	if not hero_1 == null: _party.append(hero_1)

	var hero_2 = __create_instance_for(HERO_2)
	if not hero_2 == null: _party.append(hero_2)

	return _party


# Private Methods


func __create_instance_for(res: Resource) -> PlayerActor:
	if res is PackedScene:
		var instance = res.instantiate()

		if instance is PlayerActor:
			return instance

	print_debug("WARN:: Failed to load the resource [%s]" % [res])
	return null

