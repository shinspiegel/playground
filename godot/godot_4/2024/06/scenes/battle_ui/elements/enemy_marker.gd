class_name EnemyMarker extends Button

@export var target: Actor


func _ready() -> void:
	pressed.connect(on_press)


func on_press() -> void:
	BattleManager.select_target(target)
