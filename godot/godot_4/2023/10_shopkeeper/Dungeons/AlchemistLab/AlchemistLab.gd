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
	
	crafter.succeed.connect(on_craft_succeed)
	crafter.failed.connect(on_craft_failed)
	crafter.hide()


func set_dungeon_area(state: bool) -> void:
	if state:
		dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_INHERIT)
	else:
		dungeon_nodes.set_deferred("process_mode", PROCESS_MODE_DISABLED)


func open_craft_selection() -> void:
	set_dungeon_area(false)
	craft_selection.show()


func close_craft_selection() -> void:
	set_dungeon_area(true)
	craft_selection.hide()


func on_craft_entry_creater() -> void:
	craft_selection.hide()
	crafter.show()


func on_craft_succeed() -> void:
	set_dungeon_area(true)
	crafter.hide()
	craft_selection.hide()


func on_craft_failed() -> void:
	set_dungeon_area(true)
	crafter.hide()
	craft_selection.hide()
