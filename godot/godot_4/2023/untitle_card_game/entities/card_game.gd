class_name CardGame extends CanvasLayer

signal turn_ended_by(entity: CharacterEntity)
signal player_turn()
signal enemty_turn()

@export var player: CharacterEntity
@export var enemy: CharacterEntity


@onready var end_turn_button: Button = $Hand/HBoxContainer/Card4/Button
@onready var player_hand: Control = %Hand

@onready var DEBUG_LABEL: Label = %DEBUG_LABEL

func _ready() -> void:
	# TODO: finished_battle.pressed.connect(func(): SignalBus.battle_finished.emit())
	turn_ended_by.connect(on_turn_finished)
	end_turn_button.pressed.connect(func(): turn_ended_by.emit(player))
	SignalBus.battle_start_against.connect(start_battle_against)


func start_battle_against(target: CharacterEntity) -> void:
	enemy = target
	reset_battle_state()
	build_hand()
	turn(player)


func on_turn_finished(entity: CharacterEntity) -> void:
	hide_hand()
	check_end_battle()
	
	if entity == player:
		turn(enemy)
		return 
	if entity == enemy:
		turn(player)
		return 


func turn(entity: CharacterEntity) -> void:
	DEBUG_LABEL.text = "Turn [%s]" % [entity.resource_name]
	
	if entity == player:
		# TODO: Process with player stuff
		player_turn.emit()
		show_hand()
		return
	
	if entity == enemy:
		# TODO: process enemy turn
		enemty_turn.emit()
		print("Turn enemy started")
		await get_tree().create_timer(1.0).timeout
		turn_ended_by.emit(entity)
		print("Turn enemy ended")
		return


func check_end_battle() -> void:
	print_debug("IMPLEMENT:: Check for the victory condition")


func reset_battle_state() -> void:
	hide_hand()
	print_debug("IMPLEMENT:: Reset player/enemy state if any")


func build_hand() -> void:
	for card in player_hand.get_child(0).get_children():
		var btn: Button = card.get_child(0)
		btn.focus_entered.connect(func(): 
			var tw = create_tween()
			tw.tween_property(btn, "scale", Vector2(1.25,1.25), 0.2).set_ease(Tween.EASE_OUT)
			tw.play()
		)
		btn.focus_exited.connect(func(): 
			var tw = create_tween()
			tw.tween_property(btn, "scale", Vector2(1,1), 0.2).set_ease(Tween.EASE_OUT)
			tw.play()
		)


func show_hand() -> void:
	var tw = create_tween()
	tw.tween_property(player_hand, "position:y", 270, 0.3).set_ease(Tween.EASE_OUT)
	tw.play()
	await tw.finished
	player_hand.get_child(0).get_child(0).get_child(0).grab_focus()


func hide_hand() -> void:
	var tw = create_tween()
	tw.tween_property(player_hand, "position:y", 370, 0.2).set_ease(Tween.EASE_OUT)
	tw.play()
	await tw.finished
	end_turn_button.release_focus()
