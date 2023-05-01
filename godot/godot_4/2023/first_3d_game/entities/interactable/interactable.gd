class_name Interactable extends Area3D

signal interacted()

@onready var label: Label3D = $Label3D
@onready var player: Player = null
@onready var input: PlayerInput = $PlayerInput


func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_leave)
	label.set_visible(false)
	clear_player()


func _process(_delta: float) -> void:
	check_interaction()


func check_interaction() -> void:
	if input.just_interacted && not player == null:
		interacted.emit()


func show_label() -> void:
	label.set_visible(true)


func hide_label() -> void:
	label.set_visible(false)


func set_player(p: Player) -> void:
	player = p


func clear_player() -> void:
	player = null


func on_body_entered(body: Node3D) -> void:
	if body is Player:
		set_player(body)
		show_label()


func on_body_leave(body: Node3D) -> void:
	if body is Player:
		clear_player()
		hide_label()

