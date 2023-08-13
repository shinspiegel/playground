extends BaseLevel

@onready var craft_definition: Control = $Overlay/CraftDefinition

func _ready() -> void:
	super._ready()
	CraftManager.started.connect(on_craft_start)
	CraftManager.ended.connect(on_craft_ended)
	craft_definition.hide()


func on_craft_start() -> void:
	print_debug(self)


func on_craft_ended() -> void:
	print_debug(self)
