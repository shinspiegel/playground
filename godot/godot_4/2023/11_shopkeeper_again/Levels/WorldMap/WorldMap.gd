extends Control

@onready var dungeon_1: Button = $Dungeon1
@onready var dungeon_2: Button = $Dungeon2
@onready var dungeon_3: Button = $Dungeon3
@onready var city: Button = $City
@onready var alchemy_lab: Button = $AlchemyLab


func _ready() -> void:
	alchemy_lab.pressed.connect(func(): print_debug("alchemy_lab"))
	city.pressed.connect(func(): print_debug("city"))
	dungeon_1.pressed.connect(func(): print_debug("dungeon_1"))
	dungeon_2.pressed.connect(func(): print_debug("dungeon_2"))
	dungeon_3.pressed.connect(func(): print_debug("dungeon_3"))
	
	alchemy_lab.grab_focus()
