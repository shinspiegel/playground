class_name Battle extends Area2D

signal player_entered()
signal battle_ended()

@export_group("Player Definitions")
@export var watch_node: Node2D
@export var player_pos: Node2D

@export_group("Enemies Data")
@export var enemies: Array[Enemy]

@export_group("Battle Status")
@export var is_active: bool = false
@export var battle_ui: BattleUI

@export var __combatent_ordered: Array[Actor] = []
@export var __turn: int = 0
@export var __waiting_turn_end: bool = false


func _ready() -> void:
	body_entered.connect(on_body_enter)


func _physics_process(_delta: float) -> void:
	if is_active and not __waiting_turn_end:
		actor_turn()


func actor_turn() -> void:
	print("turn started")
	__waiting_turn_end = true

	var index: int =  __turn % __combatent_ordered.size()
	var current_actor = __combatent_ordered[index]

	current_actor.act_turn()

	await current_actor.turn_ended

	__waiting_turn_end = false
	__turn += 1

	print("turn ended")


func on_body_enter(node: Node2D) -> void:
	if node == watch_node:
		player_entered.emit()



func start_battle(party: Array[Actor]) -> void:
	__combatent_ordered.append_array(enemies)
	__combatent_ordered.append_array(party)
	__combatent_ordered.sort_custom(func(a: Actor,b: Actor): return b.stats.speed < a.stats.speed)
	battle_ui.show()
	__turn = 0
	is_active = true


func end_battle() -> void:
	is_active = false
	battle_ended.emit()
	__turn = 0
