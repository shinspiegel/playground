extends Node2D

@export var amount: int = 1
@export var colddown: float = 1.0
@onready var regen_colddown: Timer = $RegenColddown


func _ready() -> void:
	regen_colddown.timeout.connect(on_timeout)
	regen_colddown.start(colddown)


func on_timeout() -> void:
	PlayerData.heal_damage(amount)
	regen_colddown.start(colddown)
