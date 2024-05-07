class_name NextSegmentArrow extends Area2D

@onready var anim_player: AnimationPlayer = %AnimationPlayer
@onready var movable: Node2D = %Movable


func _ready() -> void:
	body_entered.connect(on_body_enter)
	body_exited.connect(on_body_exit)
	movable.modulate = Color.TRANSPARENT


func on_body_enter(body: Node2D) -> void:
	if body is Player:
		var tw := create_tween()
		tw.tween_property(movable, "modulate", Color(1,1,1,0.5), 0.3)
		tw.play()
		anim_player.play("anim")


func on_body_exit(body: Node2D) -> void:
	if body is Player:
		var tw := create_tween()
		tw.tween_property(movable, "modulate", Color.TRANSPARENT, 0.3)
		tw.play()
		anim_player.stop()
