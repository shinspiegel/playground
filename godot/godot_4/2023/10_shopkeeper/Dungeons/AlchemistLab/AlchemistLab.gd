extends BaseDungeon

@onready var dungeon_nodes: Node2D = $DungeonNodes
@onready var craft_selection: CraftSelection = $Overlay/CraftSelection
@onready var craft_station: InteractableItem = $DungeonNodes/CraftStation


func _ready() -> void:
	super._ready()
	craft_station.interacted.connect(open_craft_selection)
	craft_selection.cancelled.connect(close_craft_selection)
	craft_selection.hide()


func open_craft_selection() -> void:
	dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	craft_selection.show()
	craft_selection.start()


func close_craft_selection() -> void:
	dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_INHERIT)
	craft_selection.hide()
