class_name PlayerStats extends Resource

export(Resource) var hit_points_resource

var hit_points: int setget , get_hit_points


func get_hit_points() -> int:
	return hit_points_resource.current


func hurt(amount = 1):
	hit_points_resource.reduce(amount)


func heal(amount = 1):
	hit_points_resource.increase(amount)
