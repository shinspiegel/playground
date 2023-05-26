class_name Coin extends Area3D

@export var score: int = 1
@export var anim_skip: float = 0.0
@export var sfx: AudioStream

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	body_entered.connect(on_body_entered)
	if anim_skip > 0.0:
		anim.seek(anim_skip)


func on_body_entered(body: Node3D) -> void:
	if body is Player:
		GameManager.play_sfx(sfx)
		GameManager.increase_score(score)
		queue_free()
