extends BaseScreen

@onready var start: Button = $MarginContainer/VBoxContainer/Start
@onready var options: Button = $MarginContainer/VBoxContainer/Options
@onready var quit: Button = $MarginContainer/VBoxContainer/Quit


func _ready() -> void:
	super()
	start.pressed.connect(func(): SignalBus.switch_to.emit(Constants.SCREENS.select))
	options.pressed.connect(func(): SignalBus.switch_to.emit(Constants.SCREENS.options))
	quit.pressed.connect(func(): get_tree().quit())
