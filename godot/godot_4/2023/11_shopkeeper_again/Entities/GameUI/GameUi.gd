extends Control

@onready var texture_progress_bar: TextureProgressBar = $MarginContainer/HeathArea/TextureProgressBar
@onready var label: Label = $MarginContainer/HeathArea/Label
@onready var hotbar_zero: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarZero
@onready var hotbar_one: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarOne
@onready var hotbar_two: TextureRect = $MarginContainer/HotbarArea/EquipamentIcons/HotbarTwo


func _ready() -> void:
	PlayerData.health_changed.connect(on_health_change)
	PlayerData.hotbar_changed.connect(on_hotbar_changed)
	__set_progress_bar_initial()
	on_hotbar_changed()


func on_health_change() -> void:
	texture_progress_bar.max_value = PlayerData.health_max
	label.text = "%s/%s" % [PlayerData.health_current, PlayerData.health_max]
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(texture_progress_bar, "value", PlayerData.health_current, 1)
	tween.play()



func on_hotbar_changed() -> void:
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


func __set_progress_bar_initial() -> void:
	texture_progress_bar.max_value = PlayerData.health_max
	texture_progress_bar.value = PlayerData.health_current
	label.text = "%s/%s" % [PlayerData.health_current, PlayerData.health_max]
