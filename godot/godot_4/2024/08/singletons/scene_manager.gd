extends CanvasLayer

signal faded_in()
signal faded_out()

const COLOR_FILL = Color(1,1,1,1)
const COLOR_OUT = Color(1,1,1,0)
const FADE_DELAY = 0.2

const SCENES = {
	"main": "res://main.tscn",
	"start": "res://screens/start_screen.tscn",
	"options": "res://screens/options.tscn",
	"credits": "res://screens/credits.tscn",
	"game_over": "res://screens/game_over.tscn",
}

@onready var control: Control = $Control
@onready var progress_bar: ProgressBar = $Control/ProgressBar

var __is_loading_visible: bool = false
var __next_scene_path: String = ""
var __loading_scene_status = ResourceLoader.THREAD_LOAD_INVALID_RESOURCE
var __progress: Array[float] = []
var __scene_delay: float = 0.3


func _ready() -> void:
	control.modulate = COLOR_OUT


func _process(_delta: float) -> void:
	if __is_loading_visible:
		__check_loading_state()


func reload(delay: float = 0.1) -> void:
	show_loading()
	await faded_in
	get_tree().reload_current_scene()
	await get_tree().create_timer(delay).timeout
	hide_loading()


func change_to_file(filepath: String, delay: float = 0.3) -> void:
	show_loading()
	await faded_in
	__next_scene_path = filepath
	__scene_delay = delay
	ResourceLoader.load_threaded_request(filepath)
	__loading_scene_status = ResourceLoader.THREAD_LOAD_IN_PROGRESS


func show_loading() -> void:
	if not __is_loading_visible:
		__clean_up()
		var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(control, "modulate", COLOR_FILL, FADE_DELAY)
		await tween.finished
		faded_in.emit()
		__is_loading_visible = true


func hide_loading() -> void:
	if __is_loading_visible:
		var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
		tween.tween_property(control, "modulate", COLOR_OUT, FADE_DELAY)
		await tween.finished
		__clean_up()
		faded_out.emit()


func quit() -> void:
	print("TODO::Make something to show the exit of the game")
	get_tree().quit()


## Private Methods


func __check_loading_state() -> void:
	__loading_scene_status = ResourceLoader.load_threaded_get_status(__next_scene_path, __progress)
	progress_bar.value = __progress[0]

	if __loading_scene_status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene_packed = ResourceLoader.load_threaded_get(__next_scene_path)
		get_tree().change_scene_to_packed(scene_packed)
		await get_tree().create_timer(__scene_delay).timeout
		hide_loading()


func __clean_up() -> void:
	__is_loading_visible = false
	__loading_scene_status = null
	__next_scene_path = ""
	__progress = []
