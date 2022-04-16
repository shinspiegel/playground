extends Area2D

signal finished_draining
signal hit_body(actor)

onready var collider: CollisionShape2D = $CollisionShape2D
onready var timer: Timer = $Timer

func _ready() -> void:
	collider.set_disabled(true)


func trigger_enable() -> void:
	if timer.is_stopped():
		collider.set_disabled(false)
		timer.start()


func _on_Timer_timeout() -> void:
	collider.set_disabled(true)
	emit_signal("finished_draining")


func _on_DrainArea_body_entered(body: Node) -> void:
	if body is Actor:
		emit_signal("hit_body", body) 
