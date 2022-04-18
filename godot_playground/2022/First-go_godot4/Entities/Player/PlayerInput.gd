class_name PlayerInput extends Node2D

@onready var inputTimer: Timer = $InputDelay

var direction: float = 0.0
var jump_press: bool = false
var jump_release: bool = false

func _ready():
	inputTimer.timeout.connect(reset)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		jump_press = true
		start_delay()
	
	if Input.is_action_just_released("ui_accept"):
		jump_release = true
		start_delay()
	
	if not Input.get_axis("ui_left", "ui_right") == 0.0:
		direction = Input.get_axis("ui_left", "ui_right")
		start_delay()


func start_delay():
	if inputTimer.time_left <= 0:
		inputTimer.start()


func reset():
	direction = 0.0
	jump_press = false
	jump_release = false
