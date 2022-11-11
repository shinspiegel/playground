extends BaseScreen

@onready var first_level: Button = $MarginContainer/VBoxContainer/HBoxContainer/Button
@onready var second_level: Button = $MarginContainer/VBoxContainer/HBoxContainer/Button2

func _ready() -> void:
	super()
	first_level.pressed.connect(func(): SignalBus.switch_to.emit(Constants.LEVELS.mining))
	second_level.pressed.connect(func(): SignalBus.switch_to.emit(Constants.LEVELS.laboratory))
