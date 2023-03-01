class_name EnemyAction extends Resource

@export var card_to_be_used: PackedScene
@export var activation_script: GDScript

func should_activate() -> bool:
	var script_instance = activation_script.new()
	
	if script_instance is ActionExample:
		return script_instance.example_method()
	
	print_debug("ERROR: Failed to create instance of action")
	return false
