class_name Enemy extends CharacterBody2D

@export_group("Data")
@export var health_max: int = 10
@export var health: int = 10

@export_group("Enemy State")
@export var is_active: bool = false

@export_group("Die Effect")
@export var die_effect: PackedScene

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var damage_receiver: DamageReceiver = $DamageReceiver


func _ready() -> void:
	visible_on_screen_notifier_2d.screen_entered.connect(__activate)
	visible_on_screen_notifier_2d.screen_exited.connect(__deactivate)
	damage_receiver.receive_damage.connect(on_damage_receive)
	health = health_max


func _physics_process(delta: float) -> void:
	if not is_active: return
	apply_gravity(delta)
	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GameManager.GRAVITY * delta * GameManager.MULTIPLIER


func on_damage_receive(damage: Damage) -> void:
	health = clampi(health - damage.amount, 0, health_max)
	if health <= 0:
		GameManager.create_node(die_effect, global_position)
		queue_free()


func __activate() -> void:
	is_active = true


func __deactivate() -> void:
	is_active = false
