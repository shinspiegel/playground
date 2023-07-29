class_name HitSlider extends Node2D

enum AREAS { good, ok, bad, fail }
const SIZE_AREA = 50
signal hit(area: AREAS)

@export var craft_entry: CraftEntry

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_fail: Node2D = $PossibleLeft/Fail
@onready var sprite_bad: Node2D = $PossibleLeft/Bad
@onready var sprite_ok: Node2D = $PossibleLeft/Ok
@onready var sprite_good: Node2D = $PossibleLeft/Good
@onready var vertical_bar: Node2D = $VerticalBar


func _ready() -> void:
	start()


func start() -> void:
	animation_player.speed_scale = craft_entry.diff_slider_speed
	set_visual_areas()
	animation_player.play("Anim")


func set_visual_areas() -> void:
	sprite_fail.scale.x = craft_entry.diff_fail
	sprite_bad.scale.x = craft_entry.diff_bad
	sprite_ok.scale.x = craft_entry.diff_ok
	sprite_good.scale.x = craft_entry.diff_good


func check_which_area() -> void:
	var pos = abs(vertical_bar.position.x)
	
	if pos < SIZE_AREA * craft_entry.diff_good:
		hit.emit(AREAS.good)
	elif pos < SIZE_AREA * craft_entry.diff_ok:
		hit.emit(AREAS.ok)
	elif pos < SIZE_AREA * craft_entry.diff_bad:
		hit.emit(AREAS.bad)
	else:
		hit.emit(AREAS.fail)
