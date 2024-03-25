class_name StoryData extends Resource

@export var chapter: int = 0:
	set(value):
		chapter = value
		emit_changed()
@export var episode: int = 0:
	set(value):
		episode = value
		emit_changed()
@export var step: int = 0:
	set(value):
		step = value
		emit_changed()


@export_group("Chapter 1 Flags","chapter_1_")
@export var actions_taken: int = 0:
	set(value):
		actions_taken = value
		emit_changed()
@export var chapter_1_push: bool = false:
	set(value):
		chapter_1_push = value
		emit_changed()
@export var chapter_1_alarm: bool = false:
	set(value):
		chapter_1_alarm = value
		emit_changed()
@export var chapter_1_clothes: bool = false:
	set(value):
		chapter_1_clothes = value
		emit_changed()
@export var chapter_1_email: bool = false:
	set(value):
		chapter_1_email = value
		emit_changed()
@export var chapter_1_train_ticket: bool = false:
	set(value):
		chapter_1_train_ticket = value
		emit_changed()

