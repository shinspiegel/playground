class_name BattleInitializer extends Area2D

@export var target: CharacterEntity

@onready var battle_off_coldown: Timer = $BattleOffColdown


func _ready() -> void:
	body_entered.connect(on_player_entered)


func on_player_entered(body: Node2D) -> void:
	if body is Player and battle_off_coldown.time_left <= 0:
		battle_off_coldown.start()
		SignalBus.battle_start_against.emit(target)
