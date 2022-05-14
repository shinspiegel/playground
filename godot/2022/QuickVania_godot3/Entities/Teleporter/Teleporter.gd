extends Area2D

export var area: String
export(int) var area_position: int = 0


func _ready() -> void:
	var con = connect("body_entered", self, "on_player_entered")

	if con != OK:
		print_debug("INFO:: Failed to connect")


func on_player_entered(body: Node):
	if body is Player:
		Helper.get_level_manager().switch_to(area, area_position)
