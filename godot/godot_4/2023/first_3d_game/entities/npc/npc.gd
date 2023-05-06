class_name NPC extends CharacterBody3D


const blue: BaseMaterial3D = preload("res://resources/placeholder_texture/placeholder_blue.tres")
const orange: BaseMaterial3D = preload("res://resources/placeholder_texture/placeholder_orange.tres")

@onready var interactable: Interactable = $Interactable
var mesh: PrimitiveMesh


func _ready() -> void:
	interactable.interacted.connect(on_interact)
	interactable.focus.connect(on_focus)
	interactable.blur.connect(on_blur)
	
	mesh = $MeshInstance3D.mesh


func on_interact() -> void:
	print(self)
	print_debug("WARN:: Should have implemented this method.")


func on_focus() -> void:
	set_thing(blue)


func on_blur() -> void:
	set_thing(orange)


func set_thing(m: BaseMaterial3D) -> void:
	mesh.material = m
