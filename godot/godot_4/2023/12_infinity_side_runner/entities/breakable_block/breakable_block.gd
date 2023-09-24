@tool 
class_name BreakableObject extends StaticBody2D

@export var max_points: int = 10
@export var hit_points: int = 10
@export var breaking_amount: float = 0.10
@export var die_effect: PackedScene

@export_group("Sprite Steps", "sprite_")
@export var sprite_undamage_texture: Texture2D
@export var sprite_damage_texture: Texture2D
@export var sprite_very_damage_texture: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_receiver: DamageReceiver = $DamageReceiver

func _ready() -> void:
	hit_points = max_points
	sprite_2d.texture = sprite_undamage_texture
	damage_receiver.receive_damage.connect(on_receive_damage)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		__update_sprite()


func on_receive_damage(damage: Damage) -> void:
	hit_points = clampi(hit_points - damage.amount, 0, max_points)
	GameManager.spawn_damage_at(damage, global_position)
	__update_sprite()
	
	if hit_points <= 0:
		if die_effect: GameManager.create_node(die_effect, global_position)
		GameManager.invoque_shake(damage.shake)
		queue_free()


func __update_sprite() -> void:
	if hit_points <= max_points * breaking_amount:
		sprite_2d.texture = sprite_very_damage_texture
	elif hit_points < max_points:
		sprite_2d.texture = sprite_damage_texture
	else:
		sprite_2d.texture = sprite_undamage_texture
