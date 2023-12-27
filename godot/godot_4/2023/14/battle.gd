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


func _ready() -> void:
	body_entered.connect(on_body_enter)


func _physics_process(_delta: float) -> void:
	if is_active:
		pass



func on_body_enter(node: Node2D) -> void:
	if node == watch_node:
		player_entered.emit()


func start_battle(party: Array[Actor]) -> void:
	__combatent_ordered.append_array(enemies)
	__combatent_ordered.append_array(party)
	__combatent_ordered.sort_custom(func(a,b): return b.battle_data.speed < a.battle_data.speed)
	is_active = true


func end_battle() -> void:
	is_active = false
	battle_ended.emit()
