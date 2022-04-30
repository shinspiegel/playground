extends "res://Scripts/States/BASE_STATE.gd"

export (PackedScene) var Spell
export (int, 0, 5) var DAMAGE : int = 1

onready var CastingPoint := get_node("CastingPoint")
onready var Timer := get_node("Timer")


func enter():
	Character.ANIM.play(name)
	return

func exit():
	return

func state_update(delta):
	if Character.INPUTS_HANDLER.RunAway.is_colliding():
		Character.state_manager("MoveAway")
		return
	if Character.ANIM.get_frame() == 4:
		cast_spell()
	

func animation_finished():
	Character.state_manager("Idle")

func cast_spell():
	if Timer.is_stopped():
		Timer.start()
		var SpellCast = Spell.instance()
		SpellCast.set_ownerID(Character.get_canvas_item().get_id())
		SpellCast.set_diretion(Character.INPUTS_HANDLER.move_direction)
		SpellCast.DAMAGE = DAMAGE
		SpellCast.set_global_position(CastingPoint.get_global_position())
		Character.get_parent().add_child(SpellCast)

