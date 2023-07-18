extends Node

enum DamageType {
	PHYSICAL,
	FIRE, 
	ACID,
}

const DMG = {
	NUMBER_SCENE = preload("res://entities/damage_number/damage_number.tscn"),
	RESOURCE = preload("res://resources/damage.gd")
}

const key_map = {
	UP = "forward",
	DOWN = "backward",
	LEFT = "left",
	RIGHT = "right",
	ATTACK = "attack",
}
