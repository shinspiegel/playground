class_name Bullet extends Node2D

@export var shoot_sfx: AudioStream
@export_range(-1.0, 0.0, 0.1) var shoot_sfx_adjust: float = 0.0
@export var direction: int = 1
@export_range(0.0, 10.0, 0.1) var speed: float = 1.0
@export var hit_effect: PackedScene
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var damage_inflictor: DamageInflictor = $DamageInflictor

var __multiplier: float = 1000.0


func _ready() -> void:
	damage_inflictor.body_entered.connect(on_body_entered)
	damage_inflictor.area_entered.connect(on_area_entered)
	visible_on_screen_notifier_2d.screen_exited.connect(on_screen_exited)
	AudioManager.play_sfx(shoot_sfx, shoot_sfx_adjust)


func _physics_process(delta: float) -> void:
	global_position.x += direction * (speed * __multiplier) * delta


func on_area_entered(_area: Area2D) -> void:
	if hit_effect: 
		GameManager.create_node(hit_effect, global_position)
	queue_free()


func on_body_entered(_body: Node2D) -> void:
	if hit_effect: 
		GameManager.create_node(hit_effect, global_position)
	queue_free()


func on_screen_exited() -> void:
	queue_free()
