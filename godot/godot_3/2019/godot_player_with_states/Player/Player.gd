extends KinematicBody2D

#variables
var motion = Vector2()
var direction = 1
var current_state
var last_state
var invencible_time : int = 0

#constants
const TYPE := "Player"
const SPEED := 120
const GRAVITY := 20

#onready var
onready var anim = $AnimationPlayer
onready var inputs = $InputsManager
onready var attack_box = $AttackBox/CollisionShape2D
onready var health = $HealthManager

#exported variable
export (PackedScene) var damage_number

onready var state_map = {
	"idle"      : $StateMachine/Idle, 
	"run"       : $StateMachine/Run,
	"jump"      : $StateMachine/Jump,
	"falling"   : $StateMachine/Falling,
	"knockback" : $StateMachine/Knockback,
	"sword"     : $StateMachine/Sword,
	"bow"       : $StateMachine/Bow
	}

func _ready():
	state_manager("idle")

func _process(delta):
	if invencible_time > 0:
		invencible_time -= 1
	
	if Input.is_action_just_pressed("btnV"):
		apply_damage(1)

func _physics_process(delta):
	current_state.update()
	motion = move_and_slide(motion, Vector2(0, -1))

func handle_gravity(multiplier : float = 1):
	if !is_on_floor():
		motion.y += GRAVITY * multiplier
	else: 
		motion.y = 0

func grounded() -> bool:
	if $GroundChecker/GroundFront.is_colliding() || $GroundChecker/GroundBack.is_colliding():
		return true
	else:
		return false

func state_manager(new_state):
	if current_state != null:
		last_state = current_state
		current_state.exit()
	
	current_state = state_map[new_state]
	current_state.enter(self)

func set_direction(newDirection : int):
	if (direction != newDirection):
		direction = newDirection
		var scale = Vector2(-1,1)
		apply_scale(scale)

func apply_damage(damage : int):
	if invencible_time <= 0:
		invencible_time = 15
		state_manager("knockback")
		health.deal_damage(damage)
		get_parent().add_child(show_damage_number(damage))

func show_damage_number(damage : int):
	var number = damage_number.instance()
	number.position = get_global_position()
	number.set_number(damage)
	return number

#
# Signal receive function
#

func _signal_animation_finished(anim_name):
	current_state.animation_finished(anim_name)

