extends BaseState

export(PackedScene) var SwordEffect
onready var swordAttackPosition = $Slash


# warning-ignore:unused_argument
func update_state(delta : float):
	character.input_vector.x = 0


func create_sword_attack() -> void:
	var swordEffect = SwordEffect.instance()
	
	character.add_child(swordEffect)
	swordEffect.global_position = swordAttackPosition.global_position


# warning-ignore:unused_argument
func on_animation_finished(animation: String):
	emit_signal("finished", "Idle")
