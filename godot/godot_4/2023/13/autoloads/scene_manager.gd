extends CanvasLayer

signal loading_entered()
signal loading_exited()


@onready var control: Control = $Control

var __is_loading_visible: bool = false


func _ready() -> void:
	control.modulate = Color(1,1,1,0)


func reload(delay: float = 0.5) -> void:
	show_loading()
	await loading_entered
	get_tree().reload_current_scene()
	await get_tree().create_timer(delay).timeout
	hide_loading()


func change_to_file(filepath: String, delay: float = 0.5) -> void:
	show_loading()
	await loading_entered
	get_tree().change_scene_to_file(filepath)
	await get_tree().create_timer(delay).timeout
	hide_loading()


func change_to_packed(scene: PackedScene, delay: float = 0.5) -> void:
	show_loading()
	await loading_entered
	get_tree().change_scene_to_packed(scene)
	await get_tree().create_timer(delay).timeout
	hide_loading()


func show_loading() -> void:
	if not __is_loading_visible:
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
		loading_exited.emit()
		__is_loading_visible = false


func quit() -> void:
	print("TODO::Fazer algo para saida do jogo")
	get_tree().quit()
