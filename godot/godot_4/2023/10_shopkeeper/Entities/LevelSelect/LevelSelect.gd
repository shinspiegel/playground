extends Control

@onready var alchemist_house: Button = $AlchemistHouse
@onready var dungeon_1: Button = $Dungeon1
@onready var dungeon_2: Button = $Dungeon2
@onready var dungeon_3: Button = $Dungeon3
@onready var city: Button = $City


func _ready() -> void:
	dungeon_1.pressed.connect(func(): GameManager.scenes.test_dungeon())
	dungeon_2.pressed.connect(func(): GameManager.scenes.test_dungeon())
	dungeon_3.pressed.connect(func(): GameManager.scenes.test_dungeon())
	
	city.pressed.connect(func(): GameManager.scenes.level_selector())
	
	alchemist_house.pressed.connect(func(): GameManager.scenes.test_dungeon())
	alchemist_house.grab_focus()
