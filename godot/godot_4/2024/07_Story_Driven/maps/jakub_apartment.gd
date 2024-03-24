extends LevelMap

@export_group("Chapter 1")
@export var intro_cut_scene: CutScene
@export var bubble_timer: Timer
@export var boxes_interactor: Interactable
@export var sofa_interactable: Interactable
@export var tv_interactable: Interactable
@export var phone_interactable: Interactable
@export var clock_interactable: Interactable
@export var wardrobe_interactable: Interactable
@export var door_interactable: Interactable
@export var sofa_conversation: Conversation

@onready var chapter_1_bubble = [
	[boxes_interactor, StoryManager.message_from(1, 0)],
	[sofa_interactable, StoryManager.message_from(1, 1)],
	[tv_interactable, StoryManager.message_from(1, 2)],
	[clock_interactable, StoryManager.message_from(1, 3)],
	[wardrobe_interactable, StoryManager.message_from(1, 4)],
	[phone_interactable, StoryManager.message_from(1, 5)],
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
	door_interactable.active = false
	intro_cut_scene.start()
	intro_cut_scene.ended.connect(on_intro_end)


func chapter_0_disable() -> void:
	if intro_cut_scene.ended.is_connected(on_intro_end):
		intro_cut_scene.ended.connect(on_intro_end)


func on_intro_end() -> void:
	StoryManager.advance_chapter()


# Chapter 1

func chapter_1_enable() -> void:
	door_interactable.active = true

	for entry in chapter_1_bubble:
		entry[0].focus.connect(on_focus.bind(PartyManager.get_leader(), entry[1]))

	MessageManager.message_chosen.connect(on_message_choosen)


func chapter_1_disable() -> void:
	for entry in chapter_1_bubble:
		if entry[0].focus.is_connected(on_focus):
			entry[0].focus.disconnect(on_focus)

	if MessageManager.message_chosen.is_connected(on_message_choosen):
		MessageManager.message_chosen.disconnect(on_message_choosen)


func on_focus(actor: Actor, message: MessageData) -> void:
	if bubble_timer.is_stopped():
		bubble_timer.start()
		MessageManager.create_bubble(actor, message, actor.message_pos.global_position)


func on_message_choosen(msg: MessageData, opt: String) -> void:
	match msg.id:
		"TV_WATCH":
			if opt == "Yes": print("YEAH!")
			if opt == "No": print("Noooo!")
