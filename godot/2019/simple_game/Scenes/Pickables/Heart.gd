extends "res://Scripts/Pickables/Pickable.gd"

export (float, 0, 1.5, 0.5) var INITIAL : float = 0

onready var ANIM := get_node("AnimationPlayer")

func _ready():
	ANIM.seek(INITIAL, true)