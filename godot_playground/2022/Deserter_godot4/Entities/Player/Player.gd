extends CharacterBody2D
class_name Player

@export var speed: float = 120
@export var jump_force: float = 120
@export var gravity: float = 400
@export var friction: float = 0.25
@export var acceleration: float = 0.1

@onready var playerInput: PlayerInput = $PlayerInput
@onready var stateManager: StateManager = $StateManager
@onready var playerAnimation: AnimationPlayer = $AnimationPlayer

var facing_dir: int = 1
var motion: Vector2 = Vector2.ZERO

func _ready() -> void:
	stateManager.state_changed.connect(self._on_state_manager_state_changed)
	pass



func _process(delta: float):
	motion = motion_velocity


func _physics_process(delta: float) -> void:
	_flip()
	stateManager.apply_state(delta)


func apply_gravity(delta: float) -> void:
	motion_velocity.y += gravity * delta


func apply_horizontal_force() -> void:
	if not playerInput.direction.x == 0:
		motion_velocity.x = lerp(motion_velocity.x, playerInput.direction.x * speed, acceleration)
	else:
		motion_velocity.x = lerp(motion_velocity.x, 0, friction)


func apply_vertical_force() -> void:
	if is_on_floor() and playerInput.jump: 
		motion_velocity.y = -jump_force


func _flip() -> void:
	if motion_velocity.x != 0:
		if motion_velocity.x > 0 and facing_dir == -1:
			scale.x *= -1
			facing_dir = 1
		if motion_velocity.x < 0 and facing_dir == 1:
			scale.x *= -1
			facing_dir = -1


func _on_state_manager_state_changed(current_state):
	$Debug/Label.text = current_state
