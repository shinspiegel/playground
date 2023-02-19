extends Loot


func grab_loot(_witch: Witch) -> void:
	SignalBus.play_sfx.emit(pickup_sound)
	var mana_restore_amount = clampi(10 * run_data.get_level_modifier(), 10, 100)
	run_data.restore_mana(mana_restore_amount)
