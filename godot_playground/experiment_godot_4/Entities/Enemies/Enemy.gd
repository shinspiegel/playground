class_name Enemy extends Character

@export var hit_points: int = 5


func _ready() -> void:
	hurt_box.hit_received.connect(on_reaceive_damage)


func hurt(damage: int) -> void:
	if hit_points - damage <= 0:
		hit_points = 0
	else:
		hit_points -= damage


func on_reaceive_damage(hit: HitBox) -> void:
	hurt(hit.damage.amount)
	change_state("Hit")
	state_manager.send_message("hit", hit)
