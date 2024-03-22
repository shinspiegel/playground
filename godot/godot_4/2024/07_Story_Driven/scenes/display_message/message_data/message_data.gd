class_name MessageData extends Resource

@export var profile: MessageProfile
@export_multiline var text: String = "NULL"
@export_range(0.1, 3.0, 0.1) var speed_ratio: float = 1.0
@export_range(0.1, 3.0, 0.1) var weight: float = 1.0
@export_range(0.1, 10.0, 0.1) var duration: float = 3.0
