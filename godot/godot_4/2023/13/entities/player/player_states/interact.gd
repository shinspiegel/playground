extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation


func _ready() -> void:
	animation_player.interact_ended.connect(on_interact_ented)


func enter() -> void:
	animation_player.interact()
	player.velocity.x = 0
	player.velocity.y = 0
	player.act_on_interactable()


func on_interact_ented() -> void:
	state_ended.emit("idle")
