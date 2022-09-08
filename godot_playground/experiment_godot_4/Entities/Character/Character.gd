class_name Character extends CharacterBody2D

const BLOCK_SIZE = 16

@export var speed: float = BLOCK_SIZE * 10.0
@export var jump_velocity = -400.0
@export var jump_max_height: float = BLOCK_SIZE * 3
@export var jump_min_heith: float = BLOCK_SIZE * 2
@export var jump_time_to_peak: float = 0.45
@export var jump_time_to_decend: float = 0.35

@onready var jump_power: float = ((2.0 * jump_max_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_max_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_max_height) / (jump_time_to_decend * jump_time_to_decend)) * -1
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_manager: StateManager = $StateManager
@onready var hurt_box: HurtBox = $HurtBox

var flip = { "is_active": true, "direction": 1 }


func _physics_process(delta: float) -> void:
	check_input()
	
	state_manager.apply(delta)
	
	check_flip()
	check_change_state()
	
	move_and_slide()


func apply_horizontal(direction: float, override_speed: float = speed, ratio: float = 1.0 ) -> void:
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
		return jump_gravity
	else:
		return fall_gravity


func check_change_state() -> void:
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
	pass
