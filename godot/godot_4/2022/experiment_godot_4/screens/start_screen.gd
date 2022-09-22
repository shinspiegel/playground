extends BaseScreen

@onready var start_button: Button = %Start
@onready var quit_button: Button = %Quit


func _ready():
	start_button.grab_focus()
	start_button.pressed.connect(start_press)
	quit_button.pressed.connect(quit_press)


func _exit_tree():
	start_button.pressed.disconnect(start_press)
	quit_button.pressed.disconnect(quit_press)


func start_press():
	SignalBus.switch_to.emit(Constants.LEVELS.level_1)


func quit_press():
	get_tree().quit()
