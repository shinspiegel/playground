class_name StoryData extends Resource

@export var chapter: int = 0
@export var episode: int = 0
@export var step: int = 0

@export_group("Chapter 1 Flags","chapter_1_")
@export var actions_taken: int = 0
@export var chapter_1_relaxed_on_tv: bool = false
@export var chapter_1_buy_ticket: bool = false


func ch_1_relax_tv() -> void:
	actions_taken += 1
	chapter_1_relaxed_on_tv = true
	emit_changed()


func ch_1_buy_ticket() -> void:
	actions_taken += 1
	chapter_1_buy_ticket = true
	emit_changed()

