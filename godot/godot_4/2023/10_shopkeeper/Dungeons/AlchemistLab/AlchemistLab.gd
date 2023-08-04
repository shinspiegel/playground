extends BaseDungeon

@onready var dungeon_nodes: Node2D = $DungeonNodes
@onready var craft_selection: CraftSelection = $Overlay/CraftSelection
@onready var craft_station: InteractableItem = $DungeonNodes/CraftStation
@onready var crafter: Crafter = $Overlay/Crafter


func _ready() -> void:
	super._ready()
	
	craft_station.interacted.connect(open_craft_selection)
	
	craft_selection.cancelled.connect(close_craft_selection)
	craft_selection.craft_created.connect(on_craft_entry_creater)
	craft_selection.hide()
	
	crafter.hide()
	crafter.succeed.connect(on_craft_succeed)
	crafter.failed.connect(on_craft_failed)


func open_craft_selection() -> void:
	dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	craft_selection.show()


func close_craft_selection() -> void:
	dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_INHERIT)
	craft_selection.hide()


func on_craft_entry_creater() -> void:
	craft_selection.hide()
	crafter.show()


func on_craft_succeed() -> void:
	dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_INHERIT)
	crafter.hide()


func on_craft_failed() -> void:
	dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_INHERIT)
	crafter.hide()
