extends Node

@export var destination: String = "res://Resources/InventoryItems/IngredientsGenerated/"
@export var ingredients_list: String = "res://Scripts/Ingredients.csv"
@export var icon_sprite_sheet: String = "res://Assets/Graphics/Items/16x16_base_item.png"


func _ready() -> void:
	clean_generated_folder()
	generate_ingredients_base()
	get_tree().quit()


func generate_ingredients_base() -> void:
	var file = FileAccess.open(ingredients_list, FileAccess.READ)
	var content = file.get_as_text()
	var lines = content.split("\n")
	
	
	for line in lines:
		if line.is_empty(): continue
		
		var cells = line.split(",")
		
		var resource = create_ingredient(
			cells[0],
			create_atlas(int(cells[1]), int(cells[2]))
		)
		
		ResourceSaver.save(
			resource, 
			"%s/%s.tres" %  [destination, resource.resource_name]
		)


func create_ingredient(ingredient_name: String, atlas: AtlasTexture) -> InventoryIngredient:
	var resource := InventoryIngredient.new()
	
	resource.resource_name = ingredient_name.replace(" ", "")
	resource.item_name = ingredient_name
	resource.icon = atlas
	
	return resource


func create_atlas(pox_x: int, pox_y: int) -> AtlasTexture:
	var atlas := AtlasTexture.new()
	atlas.set_atlas(load(icon_sprite_sheet))
	atlas.region = Rect2(pox_x, pox_y, 16, 16)
	return atlas


func clean_generated_folder() -> void:
	var path = "res://Resources/InventoryItems/IngredientsGenerated/"
	var files = DirAccess.open(path).get_files()
	
	for file in files:
		var filePath = "%s/%s" % [path, file]
		DirAccess.remove_absolute(filePath)
