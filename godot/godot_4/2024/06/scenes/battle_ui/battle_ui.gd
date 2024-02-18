class_name BattleUI extends CanvasLayer

@onready var enemy_markers: Control = %EnemiesMarkers
@onready var cursor_hand: CursorHand = %CursorHand
@onready var actor_panel: ActorPanel = %ActorPanel


func _ready() -> void:
	BattleManager.battle_started.connect(on_battle_start)
	BattleManager.battle_ended.connect(on_battle_end)
	hide()


func on_battle_start() -> void:
	show()


func on_battle_end() -> void:
	hide()

