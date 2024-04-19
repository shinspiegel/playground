class_name Damage extends Resource

@export var amount: int = 10
@export_range(0.0, 3.0, 0.1) var impact: float = 0.5
@export var is_critical: bool = false
@export var source_position: Vector2 = Vector2.ZERO

