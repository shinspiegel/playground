class_name SpikeEnemy extends Area3D


func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node3D) -> void:
	if body is Player: 
		GameManager.level_manager.reload_current_scene()
