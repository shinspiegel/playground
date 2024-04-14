extends CanvasLayer

@export var player: Player
@export var label: Label


func _ready() -> void:
	var sm: StateMachine = player.get_node("StateMachine")
	sm.state_changed.connect(on_player_state_change)


func on_player_state_change(state: String) -> void:
	label.text = "Player State: [%s]" % [state]
