class_name BubbleMessageStarter extends Area2D

@export var actor: Actor
@export var possible_messages: Array[MessageData] = []
@export_range(0.0, 3.0, 0.1) var colddown: float = 0.5
@export var rand_pos: Vector2 = Vector2.ZERO
@onready var timer: Timer = $Timer


func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if timer.is_stopped() and node is PlayerActor and node.is_user_controlled:
		var pos: Vector2 = actor.message_pos.global_position

		if not rand_pos.is_zero_approx():
			pos.x += randf_range(-rand_pos.x, rand_pos.x)
			pos.y += randf_range(-rand_pos.y, rand_pos.y)

		MessageManager.create_bubble(actor, MessageManager.random_bubble_weighted(possible_messages), pos)
		timer.start(colddown)

