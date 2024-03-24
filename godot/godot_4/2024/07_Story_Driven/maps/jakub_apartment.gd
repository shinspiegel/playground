extends LevelMap

@export_group("Chapter 1")
@export var intro_cut_scene: CutScene
@export_subgroup("Bubble Messages")
@export var bubble_timer: Timer
@export var boxes_interactor: Interactable
@export var sofa_interactable: Interactable
@export var tv_interactable: Interactable
@export var phone_interactable: Interactable
@export var clock_interactable: Interactable
@export var wardrobe_interactable: Interactable

@onready var bubble_message = [
	[boxes_interactor, MessageManager.message_at(0)],
	[sofa_interactable, MessageManager.message_at(1)],
	[tv_interactable, MessageManager.message_at(2)],
	[clock_interactable, MessageManager.message_at(3)],
	[wardrobe_interactable, MessageManager.message_at(4)],
	[phone_interactable, MessageManager.message_at(5)],
]


func on_story_change(story: StoryData) -> void:
	chapter_0_disable()
	chapter_1_disable()

	match story.chapter:
		0: chapter_0_enable()
		1: chapter_1_enable()
		_: pass


# Chapter 0

func chapter_0_enable() -> void:
	intro_cut_scene.start()
	intro_cut_scene.ended.connect(on_intro_end)


func chapter_0_disable() -> void:
	if intro_cut_scene.ended.is_connected(on_intro_end):
		intro_cut_scene.ended.connect(on_intro_end)


func on_intro_end() -> void:
	StoryManager.advance_chapter()


# Chapter 2

func chapter_1_enable() -> void:
	for entry in bubble_message:
		entry[0].focus.connect(on_focus.bind(PartyManager.get_leader(), entry[1]))


func chapter_1_disable() -> void:
	for entry in bubble_message:
		if entry[0].focus.is_connected(on_focus):
			entry[0].focus.disconnect(on_focus)


func on_focus(actor: Actor, message: MessageData) -> void:
	if bubble_timer.is_stopped():
		bubble_timer.start()
		MessageManager.create_bubble(actor, message, actor.message_pos.global_position)

