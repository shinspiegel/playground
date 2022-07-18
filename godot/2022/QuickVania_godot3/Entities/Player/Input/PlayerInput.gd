class_name PlayerInput extends Node

export var direction: float = 0.0
export var jump_press: bool = false
export var jump_release: bool = false
export var attack: bool = false
export var charge_release: bool = false
export var charge_attack: bool = false
export var dash: bool = false

onready var timer: Timer = $HoldToStartChargeTimer


func _ready() -> void:
	setup_timer()


func _process(_delta: float) -> void:
	jump_press = false
	jump_release = false
	attack = false
	charge_release = false
	dash = false

	if Input.is_action_just_pressed(KeysMap.JUMP):
		jump_press = true

	if Input.is_action_just_released(KeysMap.JUMP):
		jump_release = true

	if Input.is_action_just_pressed(KeysMap.ATTACK):
		attack = true
		timer.start()

	if Input.is_action_just_released(KeysMap.ATTACK):
		charge_release = true
		charge_attack = false
		timer.stop()

	if Input.is_action_pressed(KeysMap.DASH):
		dash = true

	direction = Input.get_axis(KeysMap.LEFT, KeysMap.RIGHT)


## SIGNAL METHODS


func on_time_out() -> void:
	charge_attack = true


## SETUP METHODS


func setup_timer() -> void:
	var con = timer.connect("timeout", self, "on_time_out")
	if not con == OK:
		print_debug("INFO:: Failed to connect hurt [%s]" % [timer.name])
