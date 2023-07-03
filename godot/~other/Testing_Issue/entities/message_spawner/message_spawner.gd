class_name MessageSpawner extends Node

@export var message_scene: PackedScene


func _ready() -> void:
	SignalBus.spawn_text_message_at.connect(spawn_message_for)
	SignalBus.spawn_text_message_for_hero.connect(spawn_message_for_hero)
	SignalBus.spawn_text_message_for_vampire.connect(spawn_message_for_vampire)


func spawn_message_for_hero(target: Node2D, text: String) -> void:
	spawn_message_for(target, text, Constants.VOICES_NAME.hero)


func spawn_message_for_vampire(target: Node2D, text: String) -> void:
	spawn_message_for(target, text, Constants.VOICES_NAME.vampire)


func spawn_message_for(target: Node2D, text: String, voice: String = Constants.VOICES_NAME.default) -> void:
	var message: MessageBubble = message_scene.instantiate()
	target.get_parent().add_child(message)
	
	message.global_position = target.global_position
	message.global_position.y -= 20
	message.voice = voice
	message.add_text(text)
	message.display()
