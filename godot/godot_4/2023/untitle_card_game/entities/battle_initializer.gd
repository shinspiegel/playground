class_name BattleInitializer extends Area2D

@export var target = "enemy_1"

@onready var battle_off_coldown: Timer = $BattleOffColdown


func _ready() -> void:
	body_entered.connect(on_player_entered)
	battle_off_coldown.timeout.connect(func(): print("OUT!"))
	SignalBus.battle_finished.connect(func(): battle_off_coldown.start())


func on_player_entered(body: Node2D) -> void:
	print("Touch!")
	if body is Player and battle_off_coldown.time_left <= 0:
		SignalBus.battle_start_against.emit(target)
