extends Node

export (String, FILE) var EmptyHeart
export (String, FILE) var FullHeart

onready var lifeContainer = get_node("Control/TextureRect/HBoxContainer").get_children()

var life : int = 1

func _ready():
	draw_hearts()

func draw_hearts():
	for n in range(0, lifeContainer.size()):
		lifeContainer[n].texture = load(EmptyHeart)
		if n < life:
			lifeContainer[n].texture = load(FullHeart)
	

func _on_Player_life_changed(new_value):
	life = new_value
	draw_hearts()