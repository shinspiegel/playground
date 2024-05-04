class_name Damage extends Resource

@export var amount: int = 10
@export_range(0.0, 3.0, 0.1) var impact: float = 0.5
@export var is_critical: bool = false

var source_node: Node2D
var source_position: Vector2:
	get:
		if not source_node == null:
			return source_node.global_position
		else:
			push_warning("missing source node, using Vector2.ZERO as default")
			return Vector2.ZERO
