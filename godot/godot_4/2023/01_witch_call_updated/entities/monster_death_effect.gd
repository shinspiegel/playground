extends Node2D

@export var death_sfx: AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	SignalBus.play_sfx.emit(death_sfx)
	animation_player.animation_finished.connect(func(_anim_name): queue_free())
	set_random_direction_sprite()


func set_random_direction_sprite() -> void:
	var rand_rotation = randi_range(0, 3)
	var flip_h = randi_range(0, 1)
	var flip_v = randi_range(0, 1)
	sprite.set_rotation_degrees(rand_rotation * 90)
	sprite.flip_h = true if flip_h == 1 else false
	sprite.flip_v = true if flip_v == 1 else false
