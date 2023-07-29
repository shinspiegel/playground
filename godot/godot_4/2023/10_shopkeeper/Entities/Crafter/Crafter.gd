class_name Crafter extends Control

signal succeed()
signal failed()

@export var craft_entry: CraftEntry

@onready var item_name_label: Label = $MarginContainer/VBoxContainer/ItemName
@onready var hit_slider: HitSlider = $MarginContainer/VBoxContainer/CenterContainer/Control/HitSlider
@onready var craft_progress: ProgressBar = $MarginContainer/VBoxContainer/CenterContainer2/HBoxContainer/CraftProgress
@onready var fail_progress: ProgressBar = $MarginContainer/VBoxContainer/CenterContainer3/HBoxContainer/FailProgress


func _ready() -> void:
	item_name_label.text = craft_entry.data_name
	
	hit_slider.start()
	hit_slider.hit.connect(on_hit)
	
	craft_progress.value = 0
	craft_progress.min_value = 0
	craft_progress.max_value = craft_entry.suc_required
	
	fail_progress.value = craft_entry.suc_fail_limit
	fail_progress.min_value = 0
	fail_progress.max_value = craft_entry.suc_fail_limit


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		hit_slider.check_which_area()


func on_hit(area: HitSlider.AREAS) -> void:
	if area < 3:
		match area:
			HitSlider.AREAS.good: add_hit(1)
			HitSlider.AREAS.ok: add_hit(0.4)
			HitSlider.AREAS.bad: add_hit(0.1)
			HitSlider.AREAS.fail: add_hit(0)
	else:
		add_fail()


func add_hit(power: float) -> void:
	power *= craft_entry.suc_multiplier
	craft_progress.value = clamp(craft_progress.value + power, 0, craft_entry.suc_required)
	
	if craft_progress.value >= craft_progress.max_value:
		succeed.emit()


func add_fail() -> void:
	fail_progress.value = clamp(fail_progress.value - 1, 0, craft_entry.suc_fail_limit)
	
	if fail_progress.value <= 0:
		failed.emit()
