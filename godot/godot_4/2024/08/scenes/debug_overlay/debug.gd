extends CanvasLayer

@export var state_label: Label
@export var hp_label: Label
@export var mp_label: Label
@export var stats: PlayerStats


func _ready() -> void:
	var state_machine: StateMachine = GameManager.player.state_machine
	state_machine.state_changed.connect(on_player_state_change)
	stats.hp_changed.connect(on_hp_change)
	stats.mp_changed.connect(on_mp_change)
	stats.mp_refil_changed.connect(on_mp_change)
	on_hp_change()
	on_mp_change()


func on_player_state_change(state: String) -> void:
	state_label.text = "Player State: [%s]" % [state]


func on_hp_change() -> void:
	hp_label.text = "HP: [%s / %s]" % [stats.hp_curr, stats.hp_max]


func on_mp_change() -> void:
	mp_label.text = "MP: [%s / %s :: %.2f]" % [stats.mp_curr, stats.mp_max, stats.mp_refil]
