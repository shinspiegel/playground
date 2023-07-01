class_name Loot extends Area2D

@export var speed: float = 120.0
@export var run_data: RunData
@export var pickup_sound: AudioStream

@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenEnabler2D


func _ready() -> void:
	notifier.screen_exited.connect(func(): queue_free())


func _physics_process(delta: float) -> void:
	position.y += speed * delta


func grab_loot(_witch: Witch) -> void:
	print_debug("WARN:: Not implemented, this should be implemented as a inherit class")

