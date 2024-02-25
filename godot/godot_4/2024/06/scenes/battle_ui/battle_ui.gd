class_name BattleUI extends CanvasLayer

const DAMAGE_NUMBER = preload("res://scenes/battle_ui/elements/damage_number.tscn")

@onready var enemy_markers: Control = %EnemiesMarkers
@onready var cursor_hand: CursorHand = %CursorHand
@onready var actor_panel: ActorPanel = %ActorPanel
@onready var damage_numbers: Control = %DamageNumbers


func _ready() -> void:
	BattleManager.battle_started.connect(on_battle_start)
	BattleManager.battle_ended.connect(on_battle_end)
	BattleManager.target_damaged.connect(on_target_damage)
	hide()


func on_battle_start() -> void:
	show()


func on_battle_end() -> void:
	hide()


func on_target_damage(target: Actor, damage: Damage) -> void:
	var instance: DamageNumber = DAMAGE_NUMBER.instantiate()
	instance.damage = damage
	damage_numbers.add_child(instance)
	instance.global_position = target.get_cursor_position()
