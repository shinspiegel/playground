class_name DamageNumber extends Node2D


@onready var number_value: Label = $LabelCenterPoint/NumberValue


func set_damage_value(damage: Damage) -> void:
	number_value.text = "%s" % [damage.amount]
