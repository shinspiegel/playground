extends PlayerState

const scene: Resource = preload("res://scenes/actor/player/player_block/player_block.tscn")

@export var anim_player: AnimationPlayer

var blocks: Array[Node2D] = []
var max_blocks: int = 1


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	player.change_animation(BLOCK)
	player.stats.consume_mana()
	player.velocity = Vector2.ZERO
	spawn_block()


func update(_delta: float) -> void:
	player.apply_gravity(_delta)
	player.apply_direction(0, player.data.friction_land, 1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == BLOCK:
		if player.input.direction > 0:
			state_machine.change_by_name(MOVE)
		else:
			state_machine.change_by_name(IDLE)


func spawn_block() -> void:
	var block: Node2D = scene.instantiate()
	block.global_position = player.block_pos.global_position
	GameManager.add_child_to_background(block)
	blocks.append(block)

	if blocks.size() > max_blocks:
		blocks[0].queue_free()
		blocks.pop_front()
