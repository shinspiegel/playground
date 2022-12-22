extends CanvasLayer

@export var heart_scene: PackedScene
@export var heart: int = 0
@export var max_heart: int = 3

@onready var heart_container: HBoxContainer = $MarginContainer/HBoxContainer/HealthContainer
@onready var mana_bar: ProgressBar = $MarginContainer/HBoxContainer/ManaBar
@onready var score: Label = $MarginContainer/HBoxContainer/Control/Score


func _ready() -> void:
	on_life_change(3)
	on_mana_change(100)
	on_score_change(0)
	SignalBus.mana_changed_to.connect(on_mana_change)
	SignalBus.life_changed_to.connect(on_life_change)
	SignalBus.score_changed_to.connect(on_score_change)


func on_mana_change(value: float) -> void:
	mana_bar.value = value


func on_life_change(value: int) -> void:
	var cur = heart_container.get_child_count()
	
	for _n in max_heart - cur:
		var h = heart_scene.instantiate()
		heart_container.add_child(h)


func on_score_change(value: int) -> void:
	score.text = str(value)
