extends KinematicBody2D

export (int) var SPEED = 120
export (int) var MAX_LIFE = 5
export (int) var GRAVITY = 20
export (NodePath) var START_STATE_PATH
export (bool) var facing_right := true

var STATE_MAP = {}
var life : int
var motion := Vector2()
var current_state = null
var last_state : String

onready var STATE_LIST := get_node("List States")
onready var START_STATE := get_node(START_STATE_PATH)
onready var INPUTS_HANDLER := get_node("InputHandler")
onready var ANIM := get_node("AnimatedSprite")
onready var SHAPE := get_node("CharacterShape2D")
onready var STATE_MARKER := get_node("DEBUG/STATE_MARKER")
onready var SENSES := get_node("SENSES")

signal life_changed(new_value)
signal state_change(new_state)

func _ready() -> void:
	for state in STATE_LIST.get_children():
		STATE_MAP[state.name] = state
	
	life = MAX_LIFE
	emit_signal("life_changed", life)
	current_state = START_STATE
	ANIM.play(current_state.name)
	state_manager(current_state.name)

func _process(delta) -> void:
	if life <= 0 && current_state.name != "Die":
		set_collision_layer_bit(0, false)
		set_collision_layer_bit(2, false)
		state_manager("Die")
	
	current_state.state_update(delta)
	verify_direction()


func _physics_process(delta) -> void:
	motion = move_and_slide(motion, Vector2.UP)
	apply_gravity()
	

func state_manager(new_state) -> void:
	if new_state != current_state.name:
		emit_signal("state_change", new_state)
		STATE_MARKER.text = new_state
		
		if last_state != new_state: 
			last_state = current_state.name
		else:
			last_state = START_STATE.name
		
		current_state.exit()
		current_state = STATE_MAP[new_state]
		current_state.enter()

func _on_AnimatedSprite_animation_finished() -> void:
	if current_state.has_method("animation_finished"):
		current_state.animation_finished()

func verify_direction() -> void:
	if motion.x > 0:
		if facing_right == false:
			facing_right = true
			apply_scale(Vector2(-1,1))
	if motion.x < 0:
		if facing_right == true:
			facing_right = false
			apply_scale(Vector2(-1,1))

func apply_gravity() -> void:
	if not is_on_floor(): 
		motion.y += GRAVITY
	else:
		motion.y = 0

func receive_damage(damage) -> void:
	if current_state.name != "Hurt":
		life = life - damage
		emit_signal("life_changed", life)
		state_manager("Hurt")

func receive_heal(heal) -> bool:
	if life == MAX_LIFE:
		return false
		
	if life + heal > MAX_LIFE:
		life = MAX_LIFE
	else: 
		life += heal
	
	emit_signal("life_changed", life)
	return true

func kill():
	queue_free()
