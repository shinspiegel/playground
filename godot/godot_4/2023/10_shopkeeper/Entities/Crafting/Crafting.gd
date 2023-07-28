extends Control

const recipe_scene = preload("res://Entities/SelectableItem/RecipeItem.tscn")
const ingredient_scene = preload("res://Entities/SelectableItem/IngredientItem.tscn")

@export var inventory: Inventory
@export var recipes: RecipesKnown

@onready var recipe_box: VBoxContainer = $RecipesWrapper/VBoxContainer/ScrollContainer/RecipeBox
@onready var ingredient_box: VBoxContainer = $IngredientsWrapper/VBoxContainer/ScrollContainer/IngredientBox
@onready var craft_button: Button = $CraftControl/VBoxContainer/HBoxContainer3/Craft
@onready var reset_button: Button = $CraftControl/VBoxContainer/HBoxContainer3/Reset
@onready var ingerdients_images: IngredientsImagesContainer = $CraftControl/VBoxContainer/IngerdientsImages


var current_recipe: RecipeBase
var selected_ingredients: Array[IngredientBase] = [] 


func _ready() -> void:
	craft_button.pressed.connect(on_craft)
	reset_button.pressed.connect(on_reset)
	
	reset_craft_status()
	update_craft_disabled()
	
	build(recipes.list, recipe_box, recipe_scene)
	build(inventory.list, ingredient_box, ingredient_scene)
	
	select_first_recipe()


func select_first_recipe() -> void:
	if recipe_box.get_child_count() > 0:
		var child = recipe_box.get_child(0)
		if child is RecipeItem: child.grab_focus()


func reset_craft_status() -> void:
	current_recipe = null
	selected_ingredients = []
	
	for child in recipe_box.get_children():
		if child is RecipeItem: 
			child.unselect(false)
	
	for child in ingredient_box.get_children():
		if child is IngredientItem:
			child.unselect(false)


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


func toggle_ingredients(ingredient_item: IngredientItem) -> void:
	if selected_ingredients.has(ingredient_item.ingredient):
		selected_ingredients.remove_at(selected_ingredients.find(ingredient_item.ingredient))
	elif selected_ingredients.size() < 3:
		selected_ingredients.append(ingredient_item.ingredient)
	else:
		ingredient_item.unselect(false)


func is_craft_enabled() -> bool:
	return selected_ingredients.size() >= 3 and current_recipe


func update_craft_disabled() -> void:
	if is_craft_enabled():
		craft_button.disabled = false
	else:
		craft_button.disabled = true


func on_selection(item, state) -> void:
	if item is RecipeItem:
		toggle_recipe(item, state)
	
	if item is IngredientItem:
		toggle_ingredients(item)
		ingerdients_images.set_textures(selected_ingredients)
	
	update_craft_disabled()


func on_craft() -> void:
	print("CRAFT!")


func on_reset() -> void:
	reset_craft_status()
	select_first_recipe()
