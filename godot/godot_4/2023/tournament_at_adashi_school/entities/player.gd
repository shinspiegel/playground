class_name Player extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree

var direction: Vector2 = Vector2.ZERO
var animation_tree_state: AnimationNodeStateMachinePlayback

const SPEED: float = 200.0


func _ready() -> void:
	animation_tree_state = animation_tree["parameters/playback"]


func _physics_process(_delta: float) -> void:
	get_direction()
	apply_move()
	apply_animation()


func apply_move() -> void:
	velocity = direction * SPEED
	move_and_slide()


func apply_animation() -> void:
	animation_tree.set("parameters/Idle/blend_position", direction)
	animation_tree.set("parameters/Move/blend_position", direction)
	
	if direction.normalized().length() > 0:
		animation_tree_state.travel("Move")
	else:
		animation_tree_state.travel("Idle")


func get_direction() -> void:
	direction = Vector2.ZERO
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
