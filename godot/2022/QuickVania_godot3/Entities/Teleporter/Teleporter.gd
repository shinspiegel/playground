extends Area2D

export(String) var area: String
export(int) var area_position: int = 0


func _ready() -> void:
	var con = connect("body_entered", self, "on_player_entered")
	if con != OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


func on_player_entered(body: Node):
	if body is Player:
		Manager.level.switch_to(area, area_position)
