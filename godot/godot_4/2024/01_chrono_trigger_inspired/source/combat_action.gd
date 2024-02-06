class_name CombatAction extends Node2D

@export var actor: Actor
@export var affects_enemies: bool = true
@export var affect_allies: bool = true

var battle: Battle
var battle_ui: BattleUI


func use_action(_target: Actor = null) -> void:
	print_debug("WARN:: You forgot to override this function")
	actor.end_turn()