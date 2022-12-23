class_name RunData extends Resource

@export var mana_bar: float = 100
@export var max_mana_var: float = 100
@export var mana_recovery_rate: float = 5
@export var initial_recovery_rate: float = 5

@export var hearts: int = 3
@export var max_hearts: int = 3

@export var level: int = 0
@export var score: int = 0


func _init() -> void:
	# Can connect on the signal bus from here
	# SignalBus is a singleton and is created before this one
	reset()


func reset() -> void:
	level = 0
	score = 0
	
	mana_bar = max_mana_var
	mana_recovery_rate = initial_recovery_rate
	
	hearts = max_hearts
	
	SignalBus.mana_changed_to.emit(mana_bar)
	SignalBus.score_changed_to.emit(score)
	SignalBus.life_changed_to.emit(hearts)


func change_mana(value: float) -> void:
	if mana_bar + value > max_mana_var:
		mana_bar = max_mana_var
	elif mana_bar + value < 0:
		mana_bar = 0
	else:
		mana_bar += value
	
	SignalBus.mana_changed_to.emit(mana_bar)


func consume_mana(value: float) -> void:
	change_mana(-value)


func restore_mana(value: float) -> void:
	change_mana(value)
