extends LevelMap

@export_group("Chapter 1")
@export var bubble_timer: Timer
@export_subgroup("Boxes")
@export var boxes_interactor: Interactable
@export var boxes_message: MessageData
@export_subgroup("Sofa")
@export var sofa_interactable: Interactable
@export var sofa_message: MessageData


func _ready() -> void:
	var list = [
		[boxes_interactor, boxes_message],
		[sofa_interactable, sofa_message],
	]

	for entry in list:
		entry[0].focus.connect(on_focus.bind(PartyManager.get_leader(), entry[1]))

	prepare()



func on_focus(actor: Actor, message: MessageData) -> void:
	if bubble_timer.is_stopped():
		bubble_timer.start()
		MessageManager.create_bubble(actor, message, actor.message_pos.global_position)

