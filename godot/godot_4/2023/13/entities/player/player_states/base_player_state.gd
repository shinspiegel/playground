class_name BasePlayerState extends BaseState

@export var player: Player
@export var animation_player: PlayerAnimation
@export var inputs: PlayerInputs
@export var can_shoot: bool = false


func _physics_process(_delta: float) -> void:
	if can_shoot and inputs.is_attack_just_pressed and player.can_shoot():
		player.shoot()
