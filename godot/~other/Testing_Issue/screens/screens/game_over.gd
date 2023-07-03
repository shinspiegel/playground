extends BaseScreen

@onready var play_again_button: Button = $MarginContainer/VBoxContainer2/PlayAgain
@onready var quit_button: Button = $MarginContainer/VBoxContainer2/Quit

func _ready() -> void:
	play_again_button.grab_focus()
	play_again_button.pressed.connect(func(): SignalBus.switch_to.emit(Constants.SCREENS.start))
	quit_button.pressed.connect(func(): get_tree().quit())
