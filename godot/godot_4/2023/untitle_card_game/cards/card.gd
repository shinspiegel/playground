class_name CardBase extends Control

@onready var wrapper: Button = $Wrapper
@onready var label: Label = $Wrapper/Label
@onready var card_image: TextureRect = $Wrapper/TextureRect 

var time_in: float = 0.3
var time_out: float = 0.2


func _ready() -> void:
	wrapper.focus_entered.connect(on_focus)
	wrapper.focus_exited.connect(on_blur)
	wrapper.pressed.connect(on_select_card)
	set_initial_wrapper_state()


func activate(owner: CharacterEntity, target: CharacterEntity) -> void:
	print_debug("WARN:: Needs to implement this method as extended")


func on_select_card() -> void:
	wrapper.release_focus()
	SignalBus.selected_card_data.emit(self)


func set_initial_wrapper_state() -> void:
	wrapper.size = Vector2(50,50)
	wrapper.position = Vector2(0,0)


func on_focus() -> void:
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT).set_parallel(true)
	tw.tween_property(wrapper, "size", Vector2(80,100), time_in)
	tw.tween_property(wrapper, "position", Vector2(-15,-50), time_in)
	tw.play()


func on_blur() -> void:
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT).set_parallel(true)
	tw.tween_property(wrapper, "size", Vector2(50,50), time_out)
	tw.tween_property(wrapper, "position", Vector2(0,0), time_out)
	tw.play()
