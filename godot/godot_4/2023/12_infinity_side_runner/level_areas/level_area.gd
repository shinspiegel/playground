class_name LevelArea extends Node2D

signal load_next()
signal area_crossed()

@onready var mark_start: Marker2D = $Markers/MarkStart
@onready var mark_end: Marker2D = $Markers/MarkEnd
@onready var load_next_notifier: VisibleOnScreenNotifier2D = $Notifiers/LoadNextNotifier
@onready var remove_notifier: VisibleOnScreenNotifier2D = $Notifiers/RemoveNotifier
@onready var despawn_timer: Timer = $DespawnTimer


func _ready() -> void:
	load_next_notifier.screen_exited.connect(on_exit)
	remove_notifier.screen_exited.connect(on_remove)
	despawn_timer.timeout.connect(on_timeout)


func on_exit() -> void:
	load_next.emit()


func on_remove() -> void:
	area_crossed.emit()
	despawn_timer.start()


func on_timeout() -> void:
	queue_free()
