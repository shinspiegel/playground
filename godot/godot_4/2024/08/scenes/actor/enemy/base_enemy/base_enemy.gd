class_name BaseEnemy extends BaseActor

@export var max_hp: int = 10
@export var hp: int = 10

@export_group("Movement")
@export var direction: int = -1


func _ready() -> void:
	hp = max_hp
	state_machine.change_initial()


func _physics_process(delta: float) -> void:
	state_machine.update(delta)
