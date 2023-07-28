class_name Crafter extends Control

@export var entry: CraftEntry

@onready var item_name_label: Label = $MarginContainer/VBoxContainer/ItemName
@onready var hit_slider: HitSlider = $MarginContainer/VBoxContainer/CenterContainer/Control/HitSlider


func _ready() -> void:
	item_name_label.text = entry.data_name
	hit_slider.start()
	hit_slider.hit.connect(on_hit)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		hit_slider.check_which_area()


func on_hit(area: HitSlider.AREAS) -> void:
	print(area)
