class_name DamageNumber extends Node2D

@export var label: Label


func set_damage(amount: int):
	label.text = str(amount)
