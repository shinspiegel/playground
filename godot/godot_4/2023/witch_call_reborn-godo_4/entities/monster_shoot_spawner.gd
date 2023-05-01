class_name MonsterShootSpawner extends Marker2D

@export var shoot_scene: PackedScene
@export var single_trigger: bool = true
@export var shoot_amount: int = 1
@export_range(0.1, 1.0, 0.1) var shoot_deplay: float = 0.2

@onready var shoot_delay_timer: Timer = $ShootDeplay

var shoots_left: int = 0
var is_shooting: bool = false


func _ready() -> void:
	reset_shoot_left()
	shoot_delay_timer.timeout.connect(apply_shoot)


func shoot() -> void:
	if not is_shooting:
		is_shooting = true
		reset_shoot_left()
		apply_shoot()


func apply_shoot() -> void:
	if shoots_left > 0:
		shoots_left -= 1
		instance_bullet()
		shoot_delay_timer.start(shoot_deplay)
	
	elif not single_trigger:
		is_shooting = false


func instance_bullet() -> void:
	var instance = shoot_scene.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.global_position = global_position


func reset_shoot_left() -> void:
	shoots_left = shoot_amount
