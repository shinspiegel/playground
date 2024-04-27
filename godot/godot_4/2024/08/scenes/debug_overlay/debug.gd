extends CanvasLayer

@export var state_label: Label
@export var hp_label: Label
@export var mp_label: Label

var stats: PlayerStats
var state_machine: StateMachine


func _ready() -> void:
	GameManager.player.ready.connect(on_player_ready)


func on_player_ready() -> void:
	state_machine = GameManager.player.state_machine
	stats = GameManager.player.stats
	state_machine.state_changed.connect(on_player_state_change)
	stats.hp_changed.connect(on_hp_change)
	stats.mp_changed.connect(on_mp_change)
	stats.mp_refil_changed.connect(on_mp_change)
	on_hp_change()
	on_mp_change()


func on_player_state_change(state: String) -> void:
	if state_label:
		state_label.text = "Player State: [%s]" % [state]


func on_hp_change() -> void:
	if hp_label:
		hp_label.text = "HP: [%s / %s]" % [stats.hp_curr, stats.hp_max]


func on_mp_change() -> void:
	if mp_label:
		mp_label.text = "MP: [%s / %s :: %.2f]" % [stats.mp_curr, stats.mp_max, stats.mp_refil]
