extends Node

signal health_changed(health, maxHealth)
signal damage_dealt(damage)
signal heal_received(heal)

export (int) var maxHealth : int = 5
export (int) var health : int

func _ready():
	heal_damage(maxHealth)

func deal_damage (damage : int) -> void:
	health -= damage
	health = int(max(0, health))
	emit_signal("health_changed", health, maxHealth)
	emit_signal("damage_dealt", damage)

func heal_damage (heal : int) -> void:
	health += heal
	health = int(min(health, maxHealth))
	emit_signal("health_changed", health, maxHealth)
	emit_signal("heal_received", heal)

func death_check() -> bool:
	if health == 0:
		return true
	else:
		return false