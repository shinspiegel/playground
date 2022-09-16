extends Node2D

enum DROP_QUALITY {Poor, Coin, Orb, Potion, Vase}

export(DROP_QUALITY) var drop_quality = DROP_QUALITY.Poor

var Coin = preload("res://Misc/Coins/Coin.tscn")
var Orb = preload("res://Misc/Orbs/Orb.tscn")
var Potion = preload("res://Misc/Potions/Potion.tscn")

var table = {
	poor = {
		"max_value": 20,
		"drop_table": [ 
			[12, null], 
			[18, Coin], 
			[19, Orb], 
			[20, Potion],
		]
	},
	coin = {
		"max_value": 20,
		"drop_table": [ 
			[5, null], 
			[16, Coin], 
			[18, Orb], 
			[20, Potion],
		]
	},
	orb = {
		"max_value": 20,
		"drop_table": [ 
			[5, null], 
			[7, Coin], 
			[18, Orb], 
			[20, Potion],
		]
	},
	potion = {
		"max_value": 20,
		"drop_table": [ 
			[5, null], 
			[7, Coin], 
			[9, Orb], 
			[20, Potion],
		]
	},
	vase = {
		"max_value": 20,
		"drop_table": [ 
			[12, Coin], 
			[18, Orb], 
			[20, Potion],
		]
	},
}


func _ready() -> void:
	randomize()


func choose_drop(drop_table_dict) -> PackedScene:
	var max_value = drop_table_dict.max_value
	var drop_table = drop_table_dict.drop_table
	
	var rand = floor(rand_range(0, max_value))
	var drop: PackedScene
	
	for option in drop_table:
		if rand <= option[0]:
			drop = option[1]
			break
	
	return drop


func drop_item(quality):
	var random_item
	
	match quality:
		DROP_QUALITY.Poor:
			random_item = choose_drop(table.poor)
		DROP_QUALITY.Coin:
			random_item = choose_drop(table.coin)
		DROP_QUALITY.Orb: 
			random_item = choose_drop(table.orb)
		DROP_QUALITY.Potion:
			random_item = choose_drop(table.potion)
		DROP_QUALITY.Vase:
			random_item = choose_drop(table.vase)
		_: 
			random_item = null
	
	if random_item != null:
		var random_instance = Utils.instance_scene_on_main(random_item, global_position)
		random_instance.global_position.x += rand_range(-4, 4)
		random_instance.global_position.y += rand_range(-4, 0)


func _on_StateMachine_state_changed(new_state: String) -> void:
	if new_state == "Die":
		drop_item(drop_quality)


func _on_Hurtbox_hit(damage) -> void:
	drop_item(drop_quality)
