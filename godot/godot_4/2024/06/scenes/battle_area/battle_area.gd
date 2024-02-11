class_name BattleArea extends Area2D



func _ready() -> void:
	body_entered.connect(on_body_enter)


func on_body_enter(body: Node) -> void:
	if body is PlayerActor:
		BattleManager.start_battle(__get_enemy_targets())


func __get_enemy_targets() -> Array[EnemyActor]:
	var actor_nodes: Array[EnemyActor] = []

	for node in get_overlapping_bodies():
		if node is EnemyActor:
			actor_nodes.append(node)

	return actor_nodes


