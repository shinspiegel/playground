class_name EnemiesMarkerArea extends Control

const ENEMY_MARKER = preload("res://scenes/battle_ui/elements/enemy_marker.tscn")


func _ready() -> void:
	BattleManager.targets_requested.connect(on_request)
	BattleManager.targets_selected.connect(on_select)


func on_request() -> void:
	for target: EnemyActor in BattleManager.current_enemy_list:
		var marker: EnemyMarker = ENEMY_MARKER.instantiate()
		add_child(marker)

		marker.target = target
		marker.global_position = target.get_cursor_position()
		marker.focus_entered.connect(on_focus_enter.bind(target))

	await get_tree().create_timer(0.1).timeout

	if get_child_count() > 0:
		get_child(0).grab_focus()


func on_select() -> void:
	for node in get_children():
		node.queue_free()


func on_focus_enter(target: Actor) -> void:
	BattleManager.target_pointed_to.emit(target)
