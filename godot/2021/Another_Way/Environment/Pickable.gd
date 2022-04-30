extends Area2D
class_name Pickable

export(String, "None", "Potion", "Mana", "Coin") var type: String = "None"
export(float) var startIn := 0.0

onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.advance(startIn)

func collect():
	queue_free()
