class_name Actor extends CharacterBody2D

signal turn_ended()
signal selected()

@export var speed = 30000.0
@export var friction = 0.3
@export var stats: ActorStats

@onready var target: BaseButton = $SelectNode


func _ready() -> void:
	target.hide()
	target.pressed.connect(func(): selected.emit())


func focus() -> void:
	target.grab_focus()


func show_target() -> void:
	target.show()


func hide_target() -> void:
	target.hide()


func act_turn() -> void:
	print_debug("WARN::Should implemente this on the inherited class")
	pass


func end_turn() -> void:
	turn_ended.emit()

