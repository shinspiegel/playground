class_name PlayerPowerUps extends Resource

export(Resource) var ammo_resource

export var is_double_jump_active: bool = true
export var is_charge_attack_active: bool = true
export var is_dash_active: bool = true

var ammo: int setget , get_ammo
var is_doulbe_jump_used: bool = false


func get_ammo() -> int:
	return ammo_resource.current


func use_ammo(amount = 1):
	ammo_resource.reduce(amount)


func recover_ammo(amount = 1):
	ammo_resource.increase(amount)
