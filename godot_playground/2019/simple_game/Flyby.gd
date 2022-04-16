extends "res://Scripts/States/BASE_STATE.gd"

export (int) var Max_Height := 70
export (float, 0, 20) var Vertical_Speed : float = 3
export (int) var DAMAGE := 1
export (bool) var going_up = true

var active := false

func state_update(delta):
	if active:
		Character.motion.x = -1 * Character.SPEED
		calculate_axix_y()

func calculate_axix_y():
	if going_up:
		Character.motion.y -= Vertical_Speed
	else: 
		Character.motion.y += Vertical_Speed
		
	if Character.motion.y < -Max_Height:
		going_up = false
	if Character.motion.y > Max_Height:
		going_up = true

func _on_VisibilityNotifier2D_screen_exited():
	Character.kill()

func _on_VisibilityNotifier2D_screen_entered():
	active = true

func _on_DamageArea_body_entered(body):
	if body.name == "Player":
		body.receive_damage(DAMAGE)
