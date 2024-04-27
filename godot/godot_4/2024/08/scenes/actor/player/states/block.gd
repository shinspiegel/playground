extends PlayerState

const scene: Resource = preload("res://scenes/actor/player/player_block/player_block.tscn")

@export var anim_player: AnimationPlayer


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(BLOCK)
	player.stats.consume_mana()
	player.velocity = Vector2.ZERO
	spawn_shoot()


func update(_delta: float) -> void:
	player.apply_gravity(_delta)
	player.apply_direction(0, player.data.friction_land, 1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == BLOCK:
		if player.input.direction > 0:
			state_machine.change_state(MOVE)
		else:
			state_machine.change_state(IDLE)


func spawn_shoot() -> void:
	var block: Node2D = scene.instantiate()
	block.global_position = player.block_pos.global_position
	GameManager.spawn(block, 0)
	player.power_ups.blocks.append(block)

	if player.power_ups.blocks.size() > player.power_ups.max_blocks:
		player.power_ups.blocks[0].queue_free()
		player.power_ups.blocks.pop_front()
