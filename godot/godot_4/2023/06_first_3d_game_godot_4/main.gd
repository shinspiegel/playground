extends Node3D
#
#@onready var label: Label = $CanvasLayer/Control/Label
#@onready var percentage: PercentageArea = $PercentageArea
#@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D
#@onready var cam1: Camera3D = $Path3D/PathFollow3D/LevelCamera
#@onready var cam2: Camera3D = $LevelCamera2


#func _ready() -> void:
#	percentage.moved.connect(on_move)
#
#
#func _process(_delta: float) -> void:
#	if Input.is_action_just_pressed("jump"):
#		if cam1.is_current():
#			cam2.make_current()
#		else: 
#			cam1.make_current()
#
#func on_move(pos: Vector3) -> void:
#	label.text = "Vector3(x: %.2f, y: %.2f,x: %.2f)" % [pos.x, pos.y, pos.z]
#	path_follow.progress_ratio = (1 - pos.z)
