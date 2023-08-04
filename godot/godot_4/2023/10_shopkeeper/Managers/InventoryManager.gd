class_name InventoryManager extends Node

@export var inventory: Array[IngredientItem]
@export var recipes_know: Array[RecipeItem]

@export var items: Dictionary = {
	"banana": preload("res://Ingredients/banana.tres"),
	"onion": preload("res://Ingredients/onion.tres"),
	"shrimp": preload("res://Ingredients/shrimp.tres"),
	"strawberry": preload("res://Ingredients/strawberry.tres"),
	"watermelon": preload("res://Ingredients/watermelon.tres"),
}
