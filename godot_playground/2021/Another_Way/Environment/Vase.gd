extends StaticBody2D

export(PackedScene) var vaseBrokenEffect
export(PackedScene) var coinScene
export(PackedScene) var manaScene
export(PackedScene) var potionScene


func _ready():
	  randomize()


func spawn_item():
	var list = [[7, coinScene], [9, manaScene], [10, potionScene]]
	var value = rand_range(0, 10)
	
	for item in list:
		if value < item[0]:
			var instance = item[1].instance()
			get_tree().current_scene.add_child(instance)
			instance.global_position = global_position
			instance.global_position.x += rand_range(-2, 2)
			instance.global_position.y += rand_range(-2, 0)
			return


func destroy():
	var instance = vaseBrokenEffect.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = global_position
	queue_free()

func _on_Hurtbox_hit(damage):
	spawn_item()
	destroy()
