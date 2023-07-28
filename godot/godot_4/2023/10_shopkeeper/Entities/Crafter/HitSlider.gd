class_name HitSlider extends Node2D

enum AREAS { good, ok, bad, fail }
const SIZE_AREA = 50
signal hit(area: AREAS)

@export_subgroup("Difficult")
@export_range(1.0, 10.0, 0.5) var slider_speed: float = 1.0

@export_subgroup("Areas Amount")
@export_range(0.0, 10.0, 0.5) var good: float = 1
@export_range(0.0, 10.0, 0.5) var ok: float = 4
@export_range(0.0, 10.0, 0.5) var bad: float = 9
@export_range(0.0, 10.0, 0.5) var fail: float = 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_fail: Node2D = $PossibleLeft/Fail
@onready var sprite_bad: Node2D = $PossibleLeft/Bad
@onready var sprite_ok: Node2D = $PossibleLeft/Ok
@onready var sprite_good: Node2D = $PossibleLeft/Good
@onready var vertical_bar: Node2D = $VerticalBar


func _ready() -> void:
	animation_player.speed_scale = slider_speed
	set_visual_areas()





func start() -> void:
	animation_player.play("Anim")


func set_visual_areas() -> void:
	sprite_fail.scale.x = fail
	sprite_bad.scale.x = bad
	sprite_ok.scale.x = ok
	sprite_good.scale.x = good


func check_which_area() -> void:
	var pos = abs(vertical_bar.position.x)
	
	if pos < SIZE_AREA * good:
		hit.emit(AREAS.good)
	elif pos < SIZE_AREA * ok:
		hit.emit(AREAS.ok)
	elif pos < SIZE_AREA * bad:
		hit.emit(AREAS.bad)
	else:
		hit.emit(AREAS.fail)
