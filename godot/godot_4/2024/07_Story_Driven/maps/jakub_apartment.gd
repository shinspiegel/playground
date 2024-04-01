extends LevelMap

@export_group("Chapter 1")
@export var intro_cut_scene: CutScene
@export var bubble_timer: Timer
@export var boxes_interactor: Interactable
@export var sofa_interactable: Interactable
@export var sofa_conversation: Conversation
@export var tv_interactable: Interactable
@export var tv_conversation: Conversation
@export var phone_interactable: Interactable
@export var clock_interactable: Interactable
@export var wardrobe_interactable: Interactable
@export var door_interactable: Interactable
@export var relax_cutscene: CutScene


func on_story_change(story: StoryData) -> void:
	print("story updated")
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
	GameManager.check_disconnect(intro_cut_scene.ended, on_intro_end)


func on_intro_end() -> void:
	StoryManager.advance_chapter()


# Chapter 1

func chapter_1_enable() -> void:
	match StoryManager.data.episode:
		0: chapter_1_step_0_enable()


func chapter_1_step_0_enable() -> void:
	if StoryManager.data.actions_taken >= 2:
		door_interactable.active = true
	else:
		door_interactable.active = false

	if StoryManager.data.chapter_1_relaxed_on_tv:
		sofa_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,8)))
		tv_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,8)))
		sofa_conversation.is_active = false
		tv_conversation.is_active = false
	else:
		sofa_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,1)))
		tv_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,2)))
		sofa_conversation.is_active = true
		tv_conversation.is_active = true

	boxes_interactor.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,0)))
	clock_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,3)))
	wardrobe_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,4)))
	phone_interactable.focus.connect(on_focus.bind(PartyManager.get_leader(), StoryManager.message_from(1,5)))

	MessageManager.message_chosen.connect(on_message_choosen)


func chapter_1_disable() -> void:
	GameManager.check_disconnect(boxes_interactor.focus, on_focus)
	GameManager.check_disconnect(sofa_interactable.focus, on_focus)
	GameManager.check_disconnect(tv_interactable.focus, on_focus)
	GameManager.check_disconnect(clock_interactable.focus, on_focus)
	GameManager.check_disconnect(wardrobe_interactable.focus, on_focus)
	GameManager.check_disconnect(phone_interactable.focus, on_focus)
	GameManager.check_disconnect(MessageManager.message_chosen, on_message_choosen)


func on_focus(actor: Actor, message: MessageData) -> void:
	if bubble_timer.is_stopped():
		bubble_timer.start()
		MessageManager.create_bubble(actor, message, actor.message_pos.global_position)


func on_message_choosen(msg: MessageData, opt: String) -> void:
	if msg.id == "1_8" and opt == "Yes":
		await MessageManager.ended
		relax_cutscene.start()
		StoryManager.data.ch_1_relax_tv()
		GameManager.change_to_cut_scene()
		await CutSceneManager.ended
		GameManager.change_to_world()

