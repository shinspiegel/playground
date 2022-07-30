extends CutScene


func play_scene() -> void:
	var hero = actors[0]

	wait_time(5)
	yield(self, "cut_scene_steped")

	move_actor(hero, Vector2(20, 0))
	yield(self, "cut_scene_steped")

	yield(self, "key_pressed")

	move_actor(hero, Vector2(20, 0))
	yield(self, "cut_scene_steped")

	print("Moved actor")
