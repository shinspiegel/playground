class_name OneWayBlock extends Node2D

@onready var player_input: PlayerInput = $PlayerInput
@onready var body: PhysicsBody2D = $Body

var __shapes: Array[CollisionShape2D] = []
var __state: bool = false


func _ready() -> void:
	for child in body.get_children():
		if child is CollisionShape2D:
			__shapes.append(child)
			child.disabled = __state


func _physics_process(_delta: float) -> void:
	if player_input.down >= 0.2 and not __state:
		set_all(true)

	if player_input.down < 0.2 and __state:
		set_all(false)


func set_all(state: bool) -> void:
	__state = state
	for item in __shapes:
		item.disabled = state

