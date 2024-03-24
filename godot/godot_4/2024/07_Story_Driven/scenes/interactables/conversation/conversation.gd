class_name Conversation extends Node2D

@export var force_idle_anim: bool = true
@export var interactable: Interactable
@export_range(0.0, 2.0, 0.1) var colddown: float = 0.3
@export var chapter: int = 0
@export var message_list: Array[int] = []

@onready var timer: Timer = $Timer


func _ready() -> void:
	interactable.interacted.connect(on_interact)
	MessageManager.ended.connect(on_finish)


func on_interact() -> void:
	if timer.is_stopped():
		if force_idle_anim:
			for member in PartyManager.party:
				member.call_deferred("play_idle", member.last_dir)

		GameManager.change_to_talk()
		MessageManager.start(StoryManager.message_list(chapter, message_list))
		await MessageManager.ended
		GameManager.change_to_world()


func on_finish() -> void:
	timer.start()
