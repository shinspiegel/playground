extends CutScene


func play_scene() -> void:
	var hero = actors[0]
	var vampire = actors[1]

	wait_time(1)
	yield(self, "cut_scene_steped")

	set_move_actor(hero, Vector2(20, 0))
	set_move_actor(vampire, Vector2(-20, 0))
	apply_move_actor()
	yield(self, "cut_scene_steped")

	speak_for(hero, "That was very fun!", "male_voice")
	yield(self, "key_pressed")

	speak_for(vampire, "That was very fun!", "female_voice")
	yield(self, "key_pressed")

	move_actor(hero, Vector2(20, 0))
	yield(self, "cut_scene_steped")
