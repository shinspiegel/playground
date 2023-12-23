class_name BasePlayerShoot extends Node2D

@export_range(0.1, 5.0, 0.1) var ratio: float = 1.0
@export var damage_inflictor: DamageInflictor
@export var wall_detector: Area2D
@export var direction: int = 1

@onready var shoot_node: Node2D = $ShootNode


func _ready() -> void:
	damage_inflictor.hit.connect(on_hit)
	wall_detector.body_entered.connect(on_hit)


func _physics_process(delta: float) -> void:
	shoot_node.position.x += Constants.SPEED * delta * ratio * direction

func on_hit(_thing) -> void:
	queue_free()
