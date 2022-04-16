extends Area2D

export(String) var lineOne := ""
export(String) var lineTwo := ""

onready var label: Label = $Node2D/Label
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	label.text = lineOne + "\n" + lineTwo


func _on_ArrowMessage_body_entered(body):
	if body is Player:
		animationPlayer.play("FadeIn")


func _on_ArrowMessage_body_exited(body):
	if body is Player:
		animationPlayer.play("FadeOut")
