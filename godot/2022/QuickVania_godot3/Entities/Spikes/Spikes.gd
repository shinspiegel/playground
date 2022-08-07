extends Node2D

onready var sprite: Sprite = $Sprite


func _ready() -> void:
	var frame = randi() % 1
	sprite.frame = frame

## OVERRIDE CLASS METHODS

## SIGNAL METHODS

## SETUP METHODS
