extends CanvasLayer

@export var run_data: RunData
@export var heart_scene: PackedScene

@onready var heart_container: HBoxContainer = $MarginContainer/HBoxContainer/HealthContainer
@onready var mana_bar: ProgressBar = $MarginContainer/HBoxContainer/ManaBar
@onready var score: Label = $MarginContainer/HBoxContainer/Control/Score


func _ready() -> void:
	on_life_change(run_data.max_hearts)
	on_mana_change(run_data.max_mana_var)
	on_score_change(run_data.score)
	SignalBus.mana_changed_to.connect(on_mana_change)
	SignalBus.life_changed_to.connect(on_life_change)
	SignalBus.score_changed_to.connect(on_score_change)


func on_mana_change(value: float) -> void:
	mana_bar.value = value


func on_life_change(_value: int) -> void:
	for child in heart_container.get_children():
		child.queue_free()
	
	for _h in run_data.hearts:
		var heart_instance = heart_scene.instantiate()
		heart_container.add_child(heart_instance)


func on_score_change(value: int) -> void:
	score.text = str(value)
