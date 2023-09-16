class_name Enemy extends CharacterBody2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@export var is_active: bool = false


func _ready() -> void:
	visible_on_screen_notifier_2d.screen_entered.connect(__activate)
	visible_on_screen_notifier_2d.screen_exited.connect(__deactivate)


func _physics_process(delta: float) -> void:
	if not is_active: return
	apply_gravity(delta)
	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GameManager.GRAVITY * delta * GameManager.MULTIPLIER


func __activate() -> void:
	is_active = true


func __deactivate() -> void:
	is_active = false
