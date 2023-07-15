extends PlayerState


func apply(_delta: float) -> void:
	var direction := player.input.get_direction(player.transform.basis)
	
	if direction:
		player.velocity.x = direction.x * player.SPEED
		player.velocity.z = direction.z * player.SPEED
