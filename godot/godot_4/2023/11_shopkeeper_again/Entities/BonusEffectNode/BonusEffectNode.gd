class_name BonusEffectNode extends Node

signal effect_triggered(effect: BonusEffect)
signal effect_ended(effect: BonusEffect)

@export_group("Effect")
@export var effect: BonusEffect

@onready var timer: Timer = $Timer

var __left_duration: float


func _ready() -> void:
	if not effect.is_instant:
		timer.timeout.connect(on_timeout)
		timer.start(effect.tick)
		__left_duration = effect.duration
	else:
		effect_triggered.emit(effect)
		queue_free()


func on_timeout() -> void:
	__left_duration = clampf(__left_duration - effect.tick, 0.0, effect.duration)
	
	if __left_duration > 0.0:
		effect_triggered.emit(effect)
		timer.start(effect.tick)
	else:
		effect_ended.emit(effect)
		queue_free()
