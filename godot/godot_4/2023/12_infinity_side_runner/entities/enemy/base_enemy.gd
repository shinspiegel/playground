class_name BaseEnemy extends CharacterBody2D

@export var health_max: int = 10
@export var health: int = 10

@export_group("Animation Frame Start")
@export_range(0.0, 2.0, 0.1) var animation_frame_start: float = 0.0

@export_group("Enemy State")
@export var is_active: bool = false

@export_group("Die Effect")
@export var die_effect: PackedScene

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var damage_receiver: DamageReceiver = $DamageReceiver
@onready var conditional_process: Node2D = $ConditionalProcess
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var damage_number_pos: Marker2D = $DamageNumberPos


func _ready() -> void:
	visible_on_screen_notifier_2d.screen_entered.connect(__activate)
	visible_on_screen_notifier_2d.screen_exited.connect(__deactivate)
	
	damage_receiver.receive_damage.connect(on_damage_receive)
	
	animation_player.seek(animation_frame_start)
	
	health = health_max
	
	if visible_on_screen_notifier_2d.is_on_screen():
		__activate()
	else:
		__deactivate()


func _physics_process(delta: float) -> void:
	if not is_active: return
	apply_gravity(delta)
	move_and_slide()


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GameManager.GRAVITY * delta * GameManager.MULTIPLIER


func on_damage_receive(damage: Damage) -> void:
	GameManager.spawn_damage_at(damage, damage_number_pos.global_position)
	health = clampi(health - damage.amount, 0, health_max)
	if health <= 0:
		if die_effect: GameManager.create_node(die_effect, global_position)
		queue_free()


func __activate() -> void:
	is_active = true
	conditional_process.process_mode = Node.PROCESS_MODE_INHERIT


func __deactivate() -> void:
	is_active = false
	conditional_process.process_mode = Node.PROCESS_MODE_DISABLED
