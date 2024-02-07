class_name DamageArea extends Area2D


func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if node is Player:
		node.hurt_player()
