extends Loot


func grab_loot(_witch: Witch) -> void:
	SignalBus.play_sfx.emit(pickup_sound)
	run_data.increase_damage()
