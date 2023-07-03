class_name SFXPlayer extends Node

@export_range(0, 1, 0.1) var master_volume: float = 1.0

func _ready() -> void:
	SignalBus.sfx.connect(play_sfx)


func play_sfx(stream: AudioStream = null, adjust_volume_db: float = 0.0) -> void:
	var player = AudioStreamPlayer.new()
	player.set_stream(stream)
	player.set_volume_db(Utils.float_to_volume_db(master_volume) + adjust_volume_db)
	player.finished.connect(func(): player.queue_free())
	add_child(player)
	player.play()
