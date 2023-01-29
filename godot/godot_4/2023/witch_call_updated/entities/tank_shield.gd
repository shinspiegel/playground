class_name TankShield extends Node2D

@export var max_shield_energy: int = 3
@export var shield_energy: int = 3

@onready var hurt_box: HurtBox = $HurtBox

var color_blue = Color8(43, 129, 227)
var color_red = Color8(237, 26, 107)


func _ready() -> void:
	shield_energy = max_shield_energy
	hurt_box.hit_received.connect(on_receive_hit)
	calculate_shade_color()


func on_receive_hit(hit: HitBox) -> void:
	shield_energy -= hit.get_damage_amount()
	calculate_shade_color()
	
	if shield_energy <= 0:
		queue_free()


func calculate_shade_color() -> void:
	var ratio = float(shield_energy) / float(max_shield_energy)
	var shaded_color = lerp(color_blue, color_red, ratio)
	set_modulate
