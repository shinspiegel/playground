class_name PlayerInput extends Node

onready var inputTimer: Timer = $InputColddown

var direction: float = 0.0
var jump_press: bool = false
var jump_release: bool = false


func _ready():
	var con = inputTimer.connect("timeout", self, "reset")

	if not con == OK:
		print_debug("INFO:: Failed to connect")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(KeysMap.JUMP):
		jump_press = true
		start_delay()

	if Input.is_action_just_released(KeysMap.JUMP):
		jump_release = true
		start_delay()

	if not Input.get_axis(KeysMap.LEFT, KeysMap.RIGHT) == 0.0:
		direction = Input.get_axis(KeysMap.LEFT, KeysMap.RIGHT)
		start_delay()


func start_delay():
	if inputTimer.time_left <= 0:
		inputTimer.start()


func reset():
	direction = 0.0
	jump_press = false
	jump_release = false
