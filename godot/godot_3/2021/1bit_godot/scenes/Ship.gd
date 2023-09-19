extends Area2D

const Bullet = preload("res://scenes/Bullet.tscn")
const ExplosionEffect = preload("res://scenes/ExplosionEffect.tscn")

export(int) var SPEED = 100
export(int) var DAMAGE = 1

signal player_death

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("ui_down"):
		position.y += SPEED * delta
	if Input.is_action_just_pressed("ui_accept"):
		fire_bullet()

func _exit_tree() -> void:
	var root = get_tree().current_scene
	var explosion = ExplosionEffect.instance()
	root.add_child(explosion)
	explosion.global_position = global_position
	emit_signal("player_death")


func fire_bullet():
	var bullet: Bullet = Bullet.instance()
	bullet.damage = DAMAGE
	
	var root_node = get_tree().current_scene
	root_node.add_child(bullet)
	bullet.global_position = global_position


func _on_Ship_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
