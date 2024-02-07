extends Node

var voice = preload("res://assets/sfx/attack3.wav")

var burps: Array[AudioStreamWAV] = [
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_1.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_2.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_3.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_4.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_5.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_6.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_7.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_8.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_9.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Burps/Burp_10.wav"),
]

var farts: Array[AudioStreamWAV] = [
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_1.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_2.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_3.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_4.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_5.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_6.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_7.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_8.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_9.wav"),
	preload("res://assets/sfx/Burps and Farts Basic/Farts/Fart_10.wav"),
]


func death_sound() -> void:
	_create_sfx(voice, 5)


func fart() -> void:
	farts.shuffle()
	var fart_stream: AudioStreamWAV = farts.front()
	fart_stream.loop_mode = AudioStreamWAV.LOOP_DISABLED
	_create_sfx(fart_stream, -10)


func burp() -> void:
	burps.shuffle()
	var burp_stream: AudioStreamWAV = burps.front()
	burp_stream.loop_mode = AudioStreamWAV.LOOP_DISABLED
	_create_sfx(burp_stream, 0)


func _create_sfx(audio: AudioStream, volume_db: float = 0.0) -> void:
	var sfx = AudioStreamPlayer.new()
	sfx.volume_db = volume_db
	sfx.stream = audio
	sfx.finished.connect(func(): sfx.queue_free())
	add_child(sfx)
	sfx.play()

