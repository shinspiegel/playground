extends PlayerState

const scene: Resource = preload("res://scenes/actor/player/player_block/player_block.tscn")

@export_range(0.1, 1.0, 0.1) var duration: float = 0.4
@export var anim_player: AnimationPlayer
@export var block_sound: AudioStream 

var __blocks: Array[Node2D] = []
var __max_blocks: int = 1
var __timer: SceneTreeTimer


func enter() -> void:
	__timer = get_tree().create_timer(duration)
	__timer.timeout.connect(on_timeout)

	if player.velocity.y < 0:
		player.velocity.y = 0

	player.change_animation(BLOCK)
	player.stats.consume_mana()

	spawn_block()
	AudioManager.create_sfx(block_sound, randf_range(0.9, 1.1))


func exit() -> void:
	__timer.timeout.disconnect(on_timeout)


func update(delta: float) -> void:
	player.apply_gravity(delta, 0.8)
	player.apply_direction(0, player.data.friction_land, 1)
	player.move_and_slide()
	player.check_flip(player.input.last_direction)


func on_timeout() -> void:
	if player.input.direction > 0:
		state_machine.change_by_name(MOVE)
	else:
		state_machine.change_by_name(IDLE)


func spawn_block() -> void:
	var block: Node2D = scene.instantiate()
	block.global_position = player.block_pos.global_position
	GameManager.add_child_to_background(block)
	__blocks.append(block)

	if __blocks.size() > __max_blocks:
		__blocks[0].queue_free()
		__blocks.pop_front()
