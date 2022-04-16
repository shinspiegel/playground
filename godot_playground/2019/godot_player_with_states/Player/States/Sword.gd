extends Node

var entity
var attack_number : int = 0
var is_attacking : bool = false
var attack_queue : bool = false

func enter(self_entity):
	entity = self_entity
	set_attackbox_collision(false)

func exit():
	attack_number = 0
	is_attacking = false
	attack_queue = false
	set_attackbox_collision(false)

func animation_finished(anim_name):
	is_attacking = false
	
	if !attack_queue:
		entity.state_manager("idle")


func update():
	entity.motion.x = 0
	
	if attack_number == 0:
		entity.anim.play("sword1")
		attack_number = 1
		is_attacking = true
	
	elif entity.inputs.is_attack_pressed() && attack_number == 1:
		if is_attacking:
			attack_queue = true
		else:
			entity.anim.play("sword2")
			attack_number = 2
			is_attacking = true
	
	elif entity.inputs.is_attack_pressed() && attack_number == 2:
		if is_attacking:
			attack_queue = true
		else:
			entity.anim.play("sword3")
			attack_number = 3
			is_attacking = true
	
	if attack_queue && !is_attacking:
		if attack_number == 1:
			entity.anim.play("sword2")
			attack_number = 2
			attack_queue = false
			is_attacking = true
		
		elif attack_number == 2:
			entity.anim.play("sword3")
			attack_number = 3
			attack_queue = false
			is_attacking = true
	
	if (!is_attacking && !attack_queue) || (attack_number == 3 && !is_attacking):
		entity.state_manager("idle")

func set_attackbox_collision(value : bool):
	entity.attack_box.set_disabled(!value)

#
# Signal received functions
#

func _on_AttackBox_body_entered(hit_info):
	if hit_info.get("TYPE") == "Enemy":
		hit_info.apply_damage(1)
