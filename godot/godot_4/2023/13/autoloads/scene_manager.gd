extends CanvasLayer

signal loading_entered()
signal loading_exited()

@onready var control: Control = $Control
@onready var progress_bar: ProgressBar = $Control/ProgressBar

var __is_loading_visible: bool = false
var __next_scene_path: String = ""
var __loading_scene_status = ResourceLoader.THREAD_LOAD_INVALID_RESOURCE
var __progress: Array[float] = []

func _ready() -> void:
	control.modulate = Color(1,1,1,0)


func _process(_delta: float) -> void:
	if __is_loading_visible:
		__check_loading_state()


func reload(delay: float = 0.5) -> void:
	show_loading()
	await loading_entered
	get_tree().reload_current_scene()
	await get_tree().create_timer(delay).timeout
	hide_loading()


func change_to_file(filepath: String, _delay: float = 0.5) -> void:
	show_loading()
	await loading_entered
	__next_scene_path = filepath
	ResourceLoader.load_threaded_request(filepath)
	__loading_scene_status = ResourceLoader.THREAD_LOAD_IN_PROGRESS


func show_loading() -> void:
	if not __is_loading_visible:
		__clean_up()
		var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(control, "modulate", Color(1,1,1,1), 0.2)
		await tween.finished
		loading_entered.emit()
		__is_loading_visible = true


func hide_loading() -> void:
	if __is_loading_visible:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(control, "modulate", Color(1,1,1,0), 0.2)
		await tween.finished
		__clean_up()
		loading_exited.emit()


func quit() -> void:
	print("TODO::Fazer algo para saida do jogo")
	get_tree().quit()


## Private Methods


func __check_loading_state() -> void:
	__loading_scene_status = ResourceLoader.load_threaded_get_status(__next_scene_path, __progress)
	progress_bar.value = __progress[0]
	
	if __loading_scene_status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene_packed = ResourceLoader.load_threaded_get(__next_scene_path)
		get_tree().change_scene_to_packed(scene_packed)
		hide_loading()


func __clean_up() -> void:
	__is_loading_visible = false
	__loading_scene_status = null
	__next_scene_path = ""
	__progress = []
