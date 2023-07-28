class_name IngredientsImagesContainer extends HBoxContainer

@export var textures: Array[Texture2D] = []

@onready var ingredient_one: TextureRect = $ColorRect/IngredientOne
@onready var ingredient_two: TextureRect = $ColorRect2/IngredientTwo
@onready var ingredient_three: TextureRect = $ColorRect3/IngredientThree


func clean() -> void:
	textures = []
	ingredient_one.texture = null
	ingredient_two.texture = null
	ingredient_three.texture = null


func set_textures(list: Array[IngredientBase]) -> void:
	match list.size():
		0:
			clean()
		1:
			ingredient_one.texture = list[0].image
			ingredient_two.texture = null
			ingredient_three.texture = null
		2: 
			ingredient_two.texture = list[0].image
			ingredient_two.texture = list[1].image
			ingredient_three.texture = null
		3: 
			ingredient_two.texture = list[0].image
			ingredient_two.texture = list[1].image
			ingredient_three.texture = list[2].image
