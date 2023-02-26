class_name CardData extends Resource

@export var label: String
@export var texture: Texture2D


func activate(owner: CharacterEntity, target: CharacterEntity) -> void:
	print_debug("WARN:: Needs to implement this method as extended")
