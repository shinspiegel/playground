class_name PlayerPowerUps extends Resource

export(Resource) var ammo_resource

var ammo: int setget , get_ammo

var is_double_jump_active: bool = false
var is_strong_attack_active: bool = false
var is_charge_attack_active: bool = false
var is_upper_attack_active: bool = false
var is_dash_active: bool = false
var is_parry_active: bool = false


func get_ammo() -> int:
	return ammo_resource.current


func use_ammo(amount = 1):
	ammo_resource.reduce(amount)


func recover_ammo(amount = 1):
	ammo_resource.increase(amount)
