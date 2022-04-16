extends InputHandler

onready var playerSense: Area2D = $PlayerSense
onready var playerSenseCollider: CollisionShape2D = $PlayerSense/CollisionShape2D


func _on_Area2D_body_entered(body: Player) -> void:
	if not body is Player: 
		return
	
	playerSenseCollider.set_disabled(true)
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(character.global_position, body.global_position, [character])
	
	if result.collider is Player: 
		act_input("Chase")


func _on_StateMachine_state_changed(new_state) -> void:
	if new_state == "Wander" or new_state == "Idle":
		playerSenseCollider.set_disabled(false)
