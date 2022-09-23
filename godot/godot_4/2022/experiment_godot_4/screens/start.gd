extends BaseScreen

@export var player_data: Resource

@onready var start_button: Button = %Start
@onready var quit_button: Button = %Quit
@onready var options_button: Button = %Options

func _ready() -> void:
	start_button.grab_focus()
	start_button.pressed.connect(func(): SignalBus.switch_to.emit(Constants.LEVELS.level_1))
	options_button.pressed.connect(func(): SignalBus.switch_to.emit(Constants.SCREENS.options))
	quit_button.pressed.connect(func(): get_tree().quit())
	
	SignalBus.play_background_music.emit(Constants.MUSICS.start)
	
	player_data.reset()
