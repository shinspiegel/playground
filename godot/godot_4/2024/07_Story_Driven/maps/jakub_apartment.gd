extends LevelMap

@export var boxes_interactor: Interactable
@export var boxes_message: MessageData


func _ready() -> void:
	boxes_interactor.focus.connect(on_box_interact)

	prepare()



func on_box_interact() -> void:
	MessageManager.create_bubble(
		get_tree().root,
		boxes_message,
		PartyManager.get_leader().message_pos.global_position,
	)
