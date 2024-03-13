class_name CutSceneBubble extends CutSceneTargetable

@export var list: Array[MessageData] = []
@export_range(0.0, 3.0, 0.1) var delay: float = 0.0
@export var rand_pos: Vector2 = Vector2.ZERO


func execute() -> void:
	for message in list:
		var message_pos: Vector2 = actor.message_pos.global_position

		if not rand_pos.is_zero_approx():
			message_pos.x += randf_range(-rand_pos.x, rand_pos.x)
			message_pos.y += randf_range(-rand_pos.y, rand_pos.y)

		MessageManager.create_bubble(actor, message, message_pos)

		if delay > 0.0:
			await GameManager.create_timer(delay).timeout
	
	ended.emit()
