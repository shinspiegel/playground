class_name Player extends CharacterBody2D

const Speed: float = 500.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree

var direction: Vector2 = Vector2.ZERO
var input = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	apply_direction()
	get_input()
	apply_movement()
	apply_animation()


func get_input() -> void:
	input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()


func apply_direction() -> void:
	velocity = input * Speed


func apply_movement() -> void:
	move_and_slide()


func apply_animation() -> void:
	animation_tree.set("parameters/blend_position", input.length())
	animation_tree.set("parameters/0/blend_position", input)
	animation_tree.set("parameters/1/blend_position", input)
