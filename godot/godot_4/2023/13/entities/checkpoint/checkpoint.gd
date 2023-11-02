class_name CheckPoint extends Area2D

@export var sprite: OutlinedSprite2D


func _ready() -> void:
	body_entered.connect(on_body_enter)


func enable() -> void:
	sprite.enable()


func disable() -> void:
	sprite.disable()


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		print_debug("WARN::Missing implementation")

