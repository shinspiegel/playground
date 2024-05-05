class_name GameUI extends Control

@onready var hp_label: Label = %HPLabel
@onready var hp_bar: ProgressBar = %HPBar
@onready var mp_label: Label = %MPLabel
@onready var mp_bar: ProgressBar = %MPBar
@onready var mp_refil_bar: ProgressBar = %RefilBar

var __player: Player


func set_player(player: Player) -> void:
	__player = player
	__player.stats.hp_changed.connect(on_hp_change)
	__player.stats.mp_changed.connect(on_mp_change)
	__player.stats.mp_refil_changed.connect(on_mp_refill_change)

	on_hp_change()
	on_mp_change()
	on_mp_refill_change()


func on_hp_change() -> void:
	hp_label.text = "%s/%s" % [__player.stats.hp_curr, __player.stats.hp_max]
	hp_bar.value = __player.stats.hp_curr
	hp_bar.max_value = __player.stats.hp_max


func on_mp_change() -> void:
	mp_label.text = "%s/%s" % [__player.stats.mp_curr, __player.stats.mp_max]
	mp_bar.value = __player.stats.mp_curr
	mp_bar.max_value = __player.stats.mp_max


func on_mp_refill_change() -> void:
	mp_refil_bar.value = __player.stats.mp_refil
	mp_refil_bar.max_value = 1.0

