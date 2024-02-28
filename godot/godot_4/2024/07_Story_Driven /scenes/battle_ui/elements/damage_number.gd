class_name DamageNumber extends Control

@export var damage: Damage
@onready var damage_number: Label = %DamageNumber


func _ready() -> void:
	if not damage: 
		push_error("missing damage property")
	damage_number.text = "%s" % [damage.amount]

