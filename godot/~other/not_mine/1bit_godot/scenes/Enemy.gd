extends Area2D

const ExplosionEffect = preload("res://scenes/ExplosionEffect.tscn")
const HitEffect = preload("res://scenes/HitSound.tscn")

export(int) var SPEED = 20
export(int) var ARMOR = 3


func _process(delta: float) -> void:
	position.x -= SPEED * delta


func explode() -> void:
	var root = get_tree().current_scene
	var explosion = ExplosionEffect.instance()
	root.add_child(explosion)
	explosion.global_position = global_position


func take_damage(damage: int):
	ARMOR -= damage
	
	if(ARMOR <= 0):
		var root = get_tree().current_scene
		if root is WorldRoot:
			root.score += 10
		
		explode()
		queue_free()


func create_particle(position: Vector2):
	var root = get_tree().current_scene
	var particle = HitEffect.instance()
	root.add_child(particle)
	particle.global_position = position


func _on_Enemy_body_entered(body: Bullet) -> void:
	if not body is Bullet:
		return
	
	take_damage(body.damage)
	create_particle(body.global_position)
	
	body.queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
