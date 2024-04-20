class_name PlayerStats extends Resource

signal hp_changed()
signal hp_zeroed()
signal hp_maxed()
signal mp_changed()
signal mp_zeroed()
signal mp_maxed()
signal mp_refil_changed()

@export_group("Hit Points", "hp_")
@export var hp_max: int = 50
@export var hp_curr: int = 0

@export_group("Mana Points", "mp_")
@export var mp_max: int = 3
@export var mp_curr: int = 0
@export var mp_refil: float = 0.0
@export var mp_refil_ratio: float = 0.7


func _init() -> void:
	reset_hp()
	reset_mp()


func change_hp(amount: int) -> void:
	hp_curr = clampi(hp_curr + amount, 0, hp_max)
	hp_changed.emit()

	if hp_curr <= 0: hp_zeroed.emit()
	if hp_curr >= hp_max: hp_maxed.emit()
	

func deal_damage(amount: int) -> void: 
	change_hp(-amount)


func heal_damage(amount: int) -> void: 
	change_hp(amount)


func change_mana(amount: int) -> void:
	mp_curr = clampi(mp_curr + amount, 0, mp_max)
	mp_changed.emit()

	if mp_curr <= 0: mp_zeroed.emit()
	if mp_curr >= mp_max: mp_maxed.emit()


func consume_mana(amount: int = -1) -> void:
	change_mana(amount)


func recover_mana(amount: int = 1) -> void:
	change_mana(amount)


func tick_mp(amount: float) -> void:
	if mp_curr < mp_max:
		mp_refil = mp_refil + (amount * mp_refil_ratio)
		mp_refil_changed.emit()

	if mp_refil > 1.0:
		mp_refil = 0
		recover_mana()


func can_use_mana() -> bool:
	return mp_curr > 0


func reset_hp() -> void:
	hp_curr = hp_max
	hp_changed.emit()


func reset_mp() -> void:
	mp_curr = mp_max
	mp_changed.emit()
