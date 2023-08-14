extends BaseLevel

@onready var craft_definition: Control = $Overlay/CraftDefinition

func _ready() -> void:
	super._ready()
	CraftManager.started.connect(on_craft_start)
	CraftManager.ended.connect(on_craft_ended)
	craft_definition.hide()


func on_craft_start() -> void:
	pause_sorted()
	craft_definition.show()


func on_craft_ended() -> void:
	craft_definition.hide()
	unpause_sorted()
