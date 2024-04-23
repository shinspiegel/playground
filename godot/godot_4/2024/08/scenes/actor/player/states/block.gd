extends PlayerState

const scene: Resource = preload("res://scenes/actor/player/player_block/player_block.tscn")

@export var anim_player: AnimationPlayer

var blocks: Array[Node2D] = []
var max_blocks: int = 1


func _ready() -> void:
	anim_player.animation_finished.connect(on_anim_finished)


func enter() -> void:
	actor.change_animation(BLOCK)
	actor.stats.consume_mana()
	actor.velocity = Vector2.ZERO
	spawn_shoot()


func update(_delta: float) -> void:
	actor.apply_gravity(_delta)
	actor.apple_direction(0, actor.data.friction_land, 1)
	actor.move_and_slide()
	actor.check_flip(actor.input.last_direction)


func on_anim_finished(anim: String) -> void:
	if anim == BLOCK:
		if actor.input.direction > 0:
			state_machine.change_state(MOVE)
		else:
			state_machine.change_state(IDLE)


func spawn_shoot() -> void:
	var block: Node2D = scene.instantiate()
	block.global_position = actor.block_pos.global_position
	GameManager.spawn(block, 0)
	blocks.append(block)

	if blocks.size() > max_blocks:
		blocks[0].queue_free()
		blocks.pop_front()
