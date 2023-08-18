extends Control

@export var player_data: PlayerData

@onready var texture_progress_bar: TextureProgressBar = $MarginContainer/HeathArea/TextureProgressBar
@onready var label: Label = $MarginContainer/HeathArea/Label
@onready var hotbar_zero: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarZero
@onready var hotbar_one: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarOne
@onready var hotbar_two: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarTwo


func _ready() -> void:
	player_data.health_changed.connect(update_health)
	player_data.hotbar_changed.connect(update_hotbar_icons)
	update_health()
	update_hotbar_icons()


func update_health() -> void:
	texture_progress_bar.value = get_player_ratio()
	label.text = "%s/%s" % [player_data.health_current, player_data.health_max]


func update_hotbar_icons() -> void:
	if player_data.hotbar_zero:
		hotbar_zero.texture = player_data.hotbar_zero.icon
	else: 
		hotbar_zero.texture = null
	
	if player_data.hotbar_one:
		hotbar_one.texture = player_data.hotbar_one.icon
	else: 
		hotbar_one.texture = null
	
	if player_data.hotbar_two:
		hotbar_two.texture = player_data.hotbar_two.icon
	else: 
		hotbar_two.texture = null


func get_player_ratio() -> float:
	return float(player_data.health_current) / float(player_data.health_max)
