class_name CardGame extends CanvasLayer


@onready var buttons_area: HBoxContainer = $MarginContainer/CenterContainer/VBoxContainer/ButtonsArea
@onready var finished_battle: Button = %FinishBattle


func _ready() -> void:
	visibility_changed.connect(func(): buttons_area.get_children()[0].grab_focus())
	finished_battle.pressed.connect(func(): SignalBus.battle_finished.emit())
