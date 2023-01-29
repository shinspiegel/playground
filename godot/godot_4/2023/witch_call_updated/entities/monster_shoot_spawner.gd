class_name MonsterShootSpawner extends Marker2D

@export var shoot_scene: PackedScene
@export var shoot_amount: int = 1
@export_range(0.1, 1.0, 0.1) var shoot_deplay: float = 0.2

@onready var shoot_delay_timer: Timer = $ShootDeplay

var shoots_left: int = 0

func _ready() -> void:
	shoots_left = shoot_amount
	
	if shoots_left > 1:
		shoot_delay_timer.timeout.connect(shoot)


func shoot() -> void:
	shoots_left -= 1
	instance_bullet()
	
	if shoots_left > 0:
		shoot_delay_timer.start(shoot_deplay)


func instance_bullet() -> void:
	var instance = shoot_scene.instantiate()
	get_parent().get_parent().add_child(instance)
	instance.global_position = global_position
