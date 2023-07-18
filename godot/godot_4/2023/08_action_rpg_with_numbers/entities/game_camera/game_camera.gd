class_name GameCamera extends Node3D

@onready var ghost_viewport: SubViewportContainer = %GhostViewport
@onready var general_holder: Node3D = %GeneralHolder
@onready var ghost_holder: Node3D = %GhostHolder
@onready var general_sub_viewport: SubViewport = %GeneralSubViewport


var shader_material: ShaderMaterial


func _ready() -> void:
	set_material()


func _process(_delta: float) -> void:
	apply_transform()
	apply_shader_to_material()


func apply_shader_to_material() -> void:
	shader_material.set_shader_parameter("general_camera_texture", general_sub_viewport.get_texture()) 


func apply_transform() -> void:
	general_holder.global_transform = global_transform
	ghost_holder.global_transform = global_transform


func set_material() -> void:
	if ghost_viewport.material is ShaderMaterial:
		shader_material = ghost_viewport.material
