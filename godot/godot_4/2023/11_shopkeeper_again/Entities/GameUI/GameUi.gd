extends Control

@onready var texture_progress_bar: TextureProgressBar = $MarginContainer/HeathArea/TextureProgressBar
@onready var label: Label = $MarginContainer/HeathArea/Label
@onready var hotbar_zero: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarZero
@onready var hotbar_one: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarOne
@onready var hotbar_two: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarTwo


func _ready() -> void:
	PlayerData.health_changed.connect(update_health)
	PlayerData.hotbar_changed.connect(update_hotbar_icons)
	update_health()
	update_hotbar_icons()


func update_health() -> void:
	texture_progress_bar.value = get_player_ratio()
	label.text = "%s/%s" % [PlayerData.health_current, PlayerData.health_max]


func update_hotbar_icons() -> void:
	if PlayerData.hotbar_zero:
		hotbar_zero.texture = PlayerData.hotbar_zero.icon
	else: 
		hotbar_zero.texture = null
	
	if PlayerData.hotbar_one:
		hotbar_one.texture = PlayerData.hotbar_one.icon
	else: 
		hotbar_one.texture = null
	
	if PlayerData.hotbar_two:
		hotbar_two.texture = PlayerData.hotbar_two.icon
	else: 
		hotbar_two.texture = null


func get_player_ratio() -> float:
	return float(PlayerData.health_current) / float(PlayerData.health_max)
