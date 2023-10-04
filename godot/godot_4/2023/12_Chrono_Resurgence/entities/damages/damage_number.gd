class_name DamageNumber extends Node2D

@export var damage: Damage
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $DamageAnimPos/Label


func _ready() -> void:
	if damage: 
		label.text = str(damage.amount)
