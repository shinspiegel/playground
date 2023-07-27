extends Control

const recipe_scene = preload("res://Entities/SelectableItem/RecipeItem.tscn")
const ingredient_scene = preload("res://Entities/SelectableItem/IngredientItem.tscn")

@export var recipe_list: Array[RecipeBase] = []
@export var ingredients_list: Array[IngredientBase] = []

@onready var recipe_box: VBoxContainer = $RecipesWrapper/VBoxContainer/ScrollContainer/RecipeBox
@onready var ingredient_box: VBoxContainer = $IngredientsWrapper/VBoxContainer/ScrollContainer/IngredientBox

var current_recipe: RecipeBase
var selected_ingredients: Array[IngredientBase] = [] 


func _ready() -> void:
	build(recipe_list, recipe_box, recipe_scene)
	build(ingredients_list, ingredient_box, ingredient_scene)
	
	if recipe_box.get_child_count() > 0:
		var child = recipe_box.get_child(0)
		if child is RecipeItem: child.grab_focus()


func build(list: Array, box: BoxContainer, scene: PackedScene) -> void:
	for item in list:
		var node = scene.instantiate()
		box.add_child(node)
		if node.has_method("set_resource"): node.set_resource(item)
		if node.has_signal("selected"): node.selected.connect(on_selection)


func toggle_recipe(recipe_item: RecipeItem, state: bool) -> void:
	if state:
		current_recipe = recipe_item.recipe
	
		for child in recipe_box.get_children():
			if child is RecipeItem and not child.recipe == current_recipe: 
				child.unselect(false)
	else:
		current_recipe = null
		
		for child in recipe_box.get_children():
			if child is RecipeItem: 
				child.unselect(false)


func toggle_ingredients(ingredient_item: IngredientItem, state: bool) -> void:
	if selected_ingredients.has(ingredient_item.ingredient):
		selected_ingredients.remove_at(selected_ingredients.find(ingredient_item.ingredient))
	elif selected_ingredients.size() < 3:
		selected_ingredients.append(ingredient_item.ingredient)
	else:
		ingredient_item.unselect(false)


func on_selection(item, state) -> void:
	if item is RecipeItem:
		toggle_recipe(item, state)

	if item is IngredientItem:
		toggle_ingredients(item, state)
