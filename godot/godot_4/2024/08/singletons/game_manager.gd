extends Node

const damage_number: Resource = preload("res://scenes/damageables/damage_number/damage_number.tscn")
const player_scene: Resource = preload("res://scenes/actor/player/player.tscn")

var player: Player


func _ready() -> void:
	player = player_scene.instantiate()


func spawn_damage_number(damage: Damage, pos: Vector2 = Vector2.ZERO, pos_variation: Vector2 = Vector2(20,20),parent: Node = null) -> void:
	var instance: DamageNumber = damage_number.instantiate()
	instance.damage = damage

	if parent == null:
		parent = get_tree().root
	
	parent.add_child(instance)

	pos.x += randf_range(-pos_variation.x, pos_variation.x)
	pos.y += randf_range(-pos_variation.y, pos_variation.y)

	instance.global_position = pos


func spawn_player_at(node: Node, pos: Vector2 = Vector2.ZERO, camera: GameCamera = null) -> void:
	node.add_child(player)
	player.global_position = pos

	if not camera == null:
		player.set_camera(camera)
