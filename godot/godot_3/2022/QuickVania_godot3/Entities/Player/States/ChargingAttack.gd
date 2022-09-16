extends BaseState

var is_charge_done: bool = false


func enter() -> void:
	if target is Player:
		is_charge_done = false
		target.change_animation(name)
		target.charge_attack_timer.connect("timeout", self, "on_charge_complete")
		target.charge_attack_timer.start()


func exit() -> void:
	if target is Player:
		is_charge_done = false
		target.charge_attack_timer.disconnect("timeout", self, "on_charge_complete")


func process(_delta: float) -> void:
	check_change_state()

	if target is Player:
		target.apply_horizontal(0.7)


func check_change_state() -> void:
	if target is Player:
		if target.attempt_to_fall():
			return

		if target.input.charge_release:
			if is_charge_done:
				target.change_state("ReleaseCharge")
			else:
				target.change_state("Idle")


## SIGNAL METHODS


func on_charge_complete() -> void:
	if target is Player:
		is_charge_done = true
		target.animation_player.play("ChargingAttackCompleted")

## SETUP METHODS
