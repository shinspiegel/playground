extends Node

signal switched_room_to(scene: BaseRoom)
signal changed_room()


## Room preloads
const room_1 = preload("res://map_areas/test_room_1.tscn")
const room_2 = preload("res://map_areas/test_room_1.tscn")
const room_3 = preload("res://map_areas/test_room_1.tscn")

## Compilation for easy of use
const rooms_named = {
	"room_1": room_1,
	"room_2": room_2,
	"room_3": room_3,
}

## Call to update the room, and trigger the signal with the current room
func change_to_room(named_room: String, position_index: int) -> void:
	var room_scene = rooms_named.get(named_room)
	
	if room_scene == null:
		print_debug("WARN:: Room not located on the named rooms")
		return
	
	var room_instance: BaseRoom = room_scene.instantiate()
	room_instance.player_spawn_index = position_index
	switched_room_to.emit(room_instance)
	changed_room.emit()
