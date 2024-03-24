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


func _ready() -> void:
	for entry in [
		[boxes_interactor, MessageManager.message_at(0)],
		[sofa_interactable, MessageManager.message_at(1)],
		[tv_interactable, MessageManager.message_at(2)],
		[clock_interactable, MessageManager.message_at(3)],
		[wardrobe_interactable, MessageManager.message_at(4)],
		[phone_interactable, MessageManager.message_at(5)],
	]:
		entry[0].focus.connect(on_focus.bind(PartyManager.get_leader(), entry[1]))

	prepare()
	intro_cut_scene.start()
	intro_cut_scene.ended.connect(func(): StoryManager.advance_chapter())


func on_focus(actor: Actor, message: MessageData) -> void:
	if bubble_timer.is_stopped():
		bubble_timer.start()
		MessageManager.create_bubble(actor, message, actor.message_pos.global_position)


