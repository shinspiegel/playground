extends CanvasLayer

@export var player_path: NodePath

@onready var label: Label = $Control/Label

var player: Player
var state: String = "None"
var hp: int = 5
var hp_max: int = 5


func _ready() -> void:
	if not player_path.is_empty():
		player = get_node(player_path)
		await player.ready
		player.state_manager.state_entered.connect(state_change)


func state_change(update_state) -> void:
	state = update_state
	update_label()


func update_label() -> void:
	label.text = "STATE: %s \n[%s,%s,%s] \nHP: %s/%s" % [
		state,
		player.state_manager.state_history[0] if player.state_manager.state_history.size() >= 1 else "NONE_0",
		player.state_manager.state_history[1] if player.state_manager.state_history.size() >= 2 else "NONE_1",
		player.state_manager.state_history[2] if player.state_manager.state_history.size() >= 3 else "NONE_2",
		hp,
		hp_max,
	]
