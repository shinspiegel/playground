class_name PlayerBlock extends CharacterBody2D

@onready var damage_receiver: DamageReceiver = %DamageReceiver
@onready var damage_pos_spawn: Node2D = %DamagePos

var max_hp: int = 30
var current_hp: int = 30


func _ready() -> void:
	damage_receiver.receive_damage.connect(on_damage_receive)
	current_hp = max_hp


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func on_damage_receive(damage: Damage) -> void:
	current_hp = clampi(current_hp - damage.amount, 0, max_hp)
	GameManager.spawn_damage_number(damage, damage_pos_spawn.global_position)

	if current_hp <= 0:
		queue_free()

