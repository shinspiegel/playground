extends KinematicBody2D

export (int) var MAX_SPEED := 15
var motion := Vector2.ZERO

onready var sprite = $Sprite
onready var colider = $Collider
onready var animationPlayer = $AnimationPlayer
