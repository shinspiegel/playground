extends CanvasLayer

@export var player: Player
@export var state_label: Label
@export var hp_label: Label
@export var stats: PlayerStats


func _ready() -> void:
	var sm: StateMachine = player.get_node("StateMachine")
	sm.state_changed.connect(on_player_state_change)
	stats.hp_changed.connect(on_hp_change)

	state_label.text = "Player State: [%s]" % [sm.current.name]
	hp_label.text = "HP: [%s / %s]" % [stats.curr_hp, stats.max_hp]


func on_player_state_change(state: String) -> void:
	state_label.text = "Player State: [%s]" % [state]


func on_hp_change() -> void:
	hp_label.text = "HP: [%s / %s]" % [stats.curr_hp, stats.max_hp]
