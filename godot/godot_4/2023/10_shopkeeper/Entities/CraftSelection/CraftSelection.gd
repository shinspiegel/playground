class_name CraftSelection extends Control

signal cancelled()
signal craft_created()

const recipe_scene = preload("res://Entities/SelectableItem/RecipeItem.tscn")
const ingredient_scene = preload("res://Entities/SelectableItem/IngredientItem.tscn")

@onready var recipe_box: VBoxContainer = $RecipesWrapper/VBoxContainer/ScrollContainer/RecipeBox
@onready var ingredient_box: VBoxContainer = $IngredientsWrapper/VBoxContainer/ScrollContainer/IngredientBox
@onready var craft_button: Button = $CraftControl/VBoxContainer/HBoxContainer3/Craft
@onready var reset_button: Button = $CraftControl/VBoxContainer/HBoxContainer3/Reset
@onready var back_button: Button = $CraftControl/VBoxContainer/HBoxContainer4/Back
@onready var ingerdients_images: IngredientsImagesContainer = $CraftControl/VBoxContainer/IngerdientsImages


func _ready() -> void:
	craft_button.pressed.connect(on_craft)
	reset_button.pressed.connect(on_reset)
	back_button.pressed.connect(func(): cancelled.emit())
	draw.connect(start)


func start() -> void:
	print("Started")
	build(GameManager.crafts.recipes_know, recipe_box, recipe_scene)
	build(GameManager.crafts.inventory, ingredient_box, ingredient_scene)
	
	reset_craft_status()
	update_craft_disabled()
	
	select_first_recipe()


func select_first_recipe() -> void:
	if recipe_box.get_child_count() > 0:
		recipe_box.get_child(0).grab_focus()


func reset_craft_status() -> void:
	GameManager.crafts.current_recipe = null
	GameManager.crafts.selected_ingredients.clear()
	
	for child in recipe_box.get_children():
		if child is RecipeItem: 
			child.unselect(false)
	
	for child in ingredient_box.get_children():
		if child is IngredientItem:
			child.unselect(false)


func build(list: Array, box: BoxContainer, scene: PackedScene) -> void:
	for node in box.get_children():
		# Needs to free on this frame
		# so I can select the updated list
		node.free() 
	
	for item in list:
		var node = scene.instantiate()
		box.add_child(node)
		if node.has_method("set_resource"): node.set_resource(item)
		if node.has_signal("selected"): node.selected.connect(on_selection)


func toggle_recipe(recipe_item: RecipeItem, state: bool) -> void:
	if state:
		GameManager.crafts.current_recipe = recipe_item.recipe
	
		for child in recipe_box.get_children():
			if child is RecipeItem and not child.recipe == GameManager.crafts.current_recipe: 
				child.unselect(false)
	else:
		GameManager.crafts.current_recipe = null
		
		for child in recipe_box.get_children():
			if child is RecipeItem: 
				child.unselect(false)


func toggle_ingredients(ingredient_item: IngredientItem) -> void:
	if GameManager.crafts.selected_ingredients.has(ingredient_item.ingredient):
		GameManager.crafts.selected_ingredients.remove_at(GameManager.crafts.selected_ingredients.find(ingredient_item.ingredient))
	elif GameManager.crafts.selected_ingredients.size() < 3:
		GameManager.crafts.selected_ingredients.append(ingredient_item.ingredient)
	else:
		ingredient_item.unselect(false)


func is_craft_enabled() -> bool:
	return GameManager.crafts.selected_ingredients.size() >= 3 and GameManager.crafts.current_recipe


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
		ingerdients_images.set_textures(GameManager.crafts.selected_ingredients)
	
	update_craft_disabled()


func on_craft() -> void:
	GameManager.crafts.generate_craft_entry()
	craft_created.emit()


func on_reset() -> void:
	reset_craft_status()
	select_first_recipe()
	ingerdients_images.set_textures(GameManager.crafts.selected_ingredients)
