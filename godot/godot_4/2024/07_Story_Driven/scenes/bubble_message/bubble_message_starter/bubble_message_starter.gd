class_name BubbleMessageStarter extends Area2D

@export var actor: Actor
@export var possible_messages: Array[MessageData] = []
@export_range(0.0, 3.0, 0.1) var colddown: float = 0.5
@onready var timer: Timer = $Timer


func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(node: Node2D) -> void:
	if timer.is_stopped() and node is PlayerActor and node.is_user_controlled:
		MessageManager.create_bubble_at(actor, MessageManager.random_bubble_weighted(possible_messages))
		timer.start(colddown)

