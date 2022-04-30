extends RigidBody2D

export (PackedScene) var explodeEffect

onready var explosionPosition: Position2D = $EffectPosition

func detonate():
	var instance = explodeEffect.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = explosionPosition.global_position
	queue_free()


func _on_TimeToExplode_timeout() -> void:
	detonate()


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		detonate()
