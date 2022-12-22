class_name RunData extends Resource

@export var mana_bar: float = 0
@export var level: int = 0
@export var score: int = 0
@export var hearts: int = 3


func reset() -> void:
	level = 0
	mana_bar = 0
	score = 0
	hearts = 3
	SignalBus.mana_changed_to.emit(mana_bar)
	SignalBus.score_changed_to.emit(score)
	SignalBus.life_changed_to.emit(hearts)
