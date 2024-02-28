extends Control

@export var data: ActorData

@onready var display: Label = $Display
@onready var total_exp: Label = $TotalExp
@onready var curve_label: Label = $CurveLabel
@onready var curve_slide: HSlider = $SamplePos
@onready var level_label: Label = $LevelLabel
@onready var level_slide: HSlider = $Level

var curve_pos: float = 0.0
var level_pos: int = 0


func _ready() -> void:
	level_slide.value_changed.connect(on_change.bind(level_slide))
	curve_slide.value_changed.connect(on_change.bind(curve_slide))
	curve_slide.grab_focus()



func _process(_delta: float) -> void:
	display.text = "Curve::[%s] Level::[%s] Sample::[%s]" % [
		curve_pos,
		level_pos,
		data.xp_curve.sample(curve_pos),
	]

	total_exp.text = "Exp::[%s] Increment::[%s]" % [
		__calculate_level_exp(level_pos), 
		__calculate_level_exp(level_pos) - __calculate_level_exp(level_pos-1)
	]



func on_change(val: float, curve: HSlider) -> void:
	if curve.name == "Level":
		level_label.text = "Level::%s" % [curve.value]
		level_pos = int(val)

	if curve.name == "SamplePos":
		curve_label.text = "Sample::%s" % [curve.value]
		curve_pos = val


func __calculate_level_exp(level: int) -> int:
	return 10 + (floori((float(level) / 100) * data.xp_curve.sample(float(level)/100) * 100000) * 10)

