class_name MonsterBase extends Node2D 

@export var hit_points: int = 2
@export var speed: float = 100.0
@export var score: int = 10

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hurt_box: HurtBox = $HurtBox
@onready var health_bar: TextureProgressBar = $Control/TextureProgressBar


func _ready() -> void:
	visible_notifier.screen_exited.connect(func(): queue_free())
	hurt_box.hit_received.connect(receive_hit)
	health_bar.max_value = hit_points
	health_bar.value = hit_points


func _physics_process(delta: float) -> void:
	apply_movement(delta)


func apply_movement(delta: float) -> void:
	position.y += speed * delta


func receive_hit(hit_box: HitBox) -> void:
	hit_points -= hit_box.damage.amount
	
	health_bar.value = hit_points
	
	if hit_points <= 0:
		die()


func die() -> void:
	SignalBus.monster_die.emit(self)
	queue_free()
