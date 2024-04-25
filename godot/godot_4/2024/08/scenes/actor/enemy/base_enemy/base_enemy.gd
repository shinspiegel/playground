class_name BaseEnemy extends BaseActor

@export var max_hp: int = 10
@export var hp: int = 10


func _ready() -> void:
	hp = max_hp
