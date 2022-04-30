#Need to extend the enemy state
extends "res://Enemies/BaseEnemy/EnemyState.gd"

func _ready():
	state_map = {
		"idle"      : $StateMachine/Idle,
		"knockback" : $StateMachine/Knockback,
		"die"       : $StateMachine/Die,
		"attack"    : $StateMachine/Attack,
		"patrol"    : $StateMachine/Run,
		}
	
	state_manager("idle")

#
# Signal received function
#

func _on_AnimationPlayer_animation_finished(anim_name):
	current_state.animation_finished(anim_name)