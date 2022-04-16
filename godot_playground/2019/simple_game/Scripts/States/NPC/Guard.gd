extends "res://Scripts/States/BASE_STATE.gd"

export (PackedScene) var Explosion
export (Color) var AlternatedColor := Color(1, 0, 0, 1)

onready var Tween := get_node("Tween")
onready var OriginalColor := Color(1,1,1,1)


func enter():
	Character.ANIM.play(name)
	Character.set_collision_layer_bit(2, false)
	Tween.stop(Character, "modulate")	
	Tween.interpolate_property(Character, "modulate", OriginalColor, AlternatedColor, 0.5,Tween.TRANS_LINEAR, Tween.EASE_OUT)
	Tween.start()
	return

func exit():
	Character.set_collision_layer_bit(2, false)
	Tween.stop(Character, "modulate")
	Tween.interpolate_property(Character, "modulate", AlternatedColor, OriginalColor,0.3,Tween.TRANS_LINEAR, Tween.EASE_IN)
	return

func state_update(delta):
	Character.motion.x = 0
	return

func animation_finished():
	if Character.current_state.name == self.name:
		spawn_explosion()
	return

func spawn_explosion():
	var Last_Postion = Character.get_global_position()
	
	if get_node("Timer").is_stopped():
		get_node("Timer").start()
		var NewExplostion = Explosion.instance()
		NewExplostion.set_global_position(Last_Postion)
		Character.get_parent().add_child(NewExplostion)
		Character.kill()
	return
