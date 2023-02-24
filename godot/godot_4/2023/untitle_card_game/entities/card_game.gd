class_name CardGame extends CanvasLayer

@export var player: CharacterEntity
@export var enemy: CharacterEntity

@onready var buttons_area: HBoxContainer = %ButtonsArea
@onready var finished_battle: Button = %FinishBattle
@onready var end_turn_button: Button = %EndTurn

var current_entity: CharacterEntity


func _ready() -> void:
	visibility_changed.connect(func(): buttons_area.get_children()[0].grab_focus())
	finished_battle.pressed.connect(func(): SignalBus.battle_finished.emit())
	SignalBus.battle_start_against.connect(start_battle_against)


func start_battle_against(target: CharacterEntity) -> void:
	enemy = target
	print("Started!")
