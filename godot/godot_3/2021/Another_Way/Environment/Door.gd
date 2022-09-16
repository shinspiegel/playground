extends StaticBody2D

onready var animationPlayer: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animationPlayer.play("DoorIdle")


func open_door():
	animationPlayer.play("DoorOpen")


func close_door():
	animationPlayer.play("DoorClose")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Door Close":
		animationPlayer.play("DoorIdle")

