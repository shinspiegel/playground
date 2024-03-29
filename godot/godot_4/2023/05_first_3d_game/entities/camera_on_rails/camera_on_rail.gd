class_name CameraOnRail extends Area3D

signal moved(percentage: Vector3)

@export var player_node: NodePath
@export_enum("x", "y", "z") var axis: String = "x"
@export var inverted: bool = false
@export var area_ratio: Vector3 = Vector3.ZERO

@onready var shape: CollisionShape3D = $MotionArea
@onready var camera_mount: PathFollow3D = $CameraPath/CameraMount
@onready var camera: Camera3D = $CameraPath/CameraMount/LevelCamera

var player: Node3D

func _ready() -> void:
	player = get_node(player_node)


func _process(_delta: float) -> void:
	area_ratio = calculate_position()
	moved.emit(area_ratio)
	adjust_camera(area_ratio[axis])


func calculate_position() -> Vector3:
	var shape_transform: Transform3D = shape.global_transform.affine_inverse()
	var relative_transform: Transform3D = player.global_transform * shape_transform
	var relative_position: Vector3 = relative_transform.origin
	var percentage_value: Vector3 = (shape.shape.size / 2 + relative_position) / shape.shape.size
	
	return Vector3(
		clampf(percentage_value.x, 0.0, 1.0),
		clampf(percentage_value.y, 0.0, 1.0),
		clampf(percentage_value.z, 0.0, 1.0),
	)


func adjust_camera(ratio: float) -> void:
	if not inverted:
		camera_mount.progress_ratio = ratio
	else: 
		camera_mount.progress_ratio = 1 - ratio
