class_name Character extends CharacterBody2D

class Flip:
	var is_active: bool = true
	var direction: int = 1

@export var speed_multiplier: float = 10.0
@export var jump_max_multiplier: float = 3.0
@export var jump_min_multiplier: float = 0.2
@export var jump_time_to_peak: float = 0.45
@export var jump_time_to_decend: float = 0.35

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_manager: StateManager = $StateManager
@onready var hurt_box: HurtBox = $HurtBox

var speed: float = Constants.BLOCK_SIZE * speed_multiplier

var jump_power: float = ((2.0 * jump_max_height) / jump_time_to_peak) * -1
var jump_max_height: float = Constants.BLOCK_SIZE * jump_max_multiplier
var jump_min_heith: float = Constants.BLOCK_SIZE * jump_min_multiplier

var gravity_fall: float = ((-2.0 * jump_max_height) / (jump_time_to_decend * jump_time_to_decend)) * -1
var gravity_jumping: float = ((-2.0 * jump_max_height) / (jump_time_to_peak * jump_time_to_peak)) * -1

var flip = Flip.new()


func _physics_process(delta: float) -> void:
	check_input()
	state_manager.apply(delta)
	check_flip()
	move_and_slide()
	check_change_state()


func apply_horizontal(direction: float = 0.0, override_speed: float = speed, ratio: float = 1.0) -> void:
	if not direction == 0.0:
		velocity.x = direction * (override_speed * ratio)
	else:
		velocity.x = move_toward(velocity.x, 0, override_speed * ratio)


func apply_vertical(power: float, ratio: float = 1.0) -> void:
	velocity.y = (abs(power) * -1) * ratio


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity() * delta


func get_gravity() -> float:
	if velocity.y < 0.0:
		return gravity_jumping
	else:
		return gravity_fall


func check_change_state() -> void:
	print_debug("WARN:: Change state method is required to be implemented")
	pass


func change_state(state: String) -> void:
	state_manager.change_state(state)


func change_animation(anim: String) -> void:
	if not animation_player == null:
		if animation_player.has_animation(anim) and not animation_player.current_animation == anim:
			animation_player.play(anim)


func check_flip() -> void:
	if flip.is_active:
		var value = velocity.x
	
		if value != 0:
			if value > 0 and flip.direction == -1:
				scale.x *= -1
				flip.direction = 1
			if value < 0 and flip.direction == 1:
				scale.x *= -1
				flip.direction = -1


func check_input() -> void:
	print_debug("WARN:: Check input is required to be implemented")
	pass