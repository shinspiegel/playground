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
	var states = ""
	for state in player.state_manager.state_history:
		states += state
		states += ", "
	
	
	label.text = "STATE: %s \n[%s] \nHP: %s/%s" % [
		state,
		states,
		hp,
		hp_max,
	]
