extends BaseLevel


func _ready() -> void:
	super._ready()
	CraftManager.started.connect(on_craft_start)
	CraftManager.ended.connect(on_craft_ended)


func on_craft_start() -> void:
	print_debug(self)


func on_craft_ended() -> void:
	print_debug(self)
