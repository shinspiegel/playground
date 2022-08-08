extends Area2D

export(int) var map_global_position_x
export(int) var map_global_position_y


func _ready() -> void:
	var con = connect("body_entered", self, "on_player_entered")
	if con != OK:
		print_debug("INFO:: Failed to connect [%s]" % [name])


func on_player_entered(body: Node) -> void:
	if body is Player:
		SignalBus.emit_signal("player_entered_room", map_global_position_x, map_global_position_y)
