extends CutScene

const dialog_list = [
	"Do you remember that day?",
	"No... What day?",
	"When we were wandering into the park at night",
	"We used to do that a lot...",
	"Yeah, we should do it more often",
	"Not sure, we need to [shake rate=10 level=3]talk..[/shake]",
	"[shake rate=10 level=3]Talk?[/shake] Like a [shake rate=10 level=3]'real'[/shake] talk?",
	"Like real [shake rate=10 level=5]'real talk'...[/shake]",
	"What happen?",
	"[shake rate=15 level=5]We... should... break... up... [/shake]",
	"[shake rate=10 level=3]Wait? What? For real?[/shake]",
	"[shake rate=10 level=2][ghost freq=5 span=0.5]Yeah, it's not working anymore[/ghost][/shake]"
]


func play_scene() -> void:
	var hero = actors[0]
	var male_voice = "male_voice"

	var vampire = actors[1]
	var female_voice = "female_voice"

	apply_tween()
	yield(self, "step_ended")

	wait_time(1)
	yield(self, "step_ended")

	set_move_actor(hero, Vector2(20, 0))
	set_move_actor(vampire, Vector2(-20, 0))
	apply_tween()
	yield(self, "step_ended")

	speak_for(hero, dialog_list[0], male_voice)
	yield(self, "step_ended")

	speak_for(vampire, dialog_list[1], female_voice)
	yield(self, "step_ended")

	speak_for(hero, dialog_list[2], male_voice)
	yield(self, "step_ended")

	speak_for(vampire, dialog_list[3], female_voice)
	yield(self, "step_ended")

	speak_for(hero, dialog_list[4], male_voice)
	yield(self, "step_ended")

	speak_for(vampire, dialog_list[5], female_voice)
	yield(self, "step_ended")

	speak_for(hero, dialog_list[6], male_voice)
	yield(self, "step_ended")

	speak_for(vampire, dialog_list[7], female_voice)
	yield(self, "step_ended")

	speak_for(hero, dialog_list[8], male_voice)
	yield(self, "step_ended")

	speak_for(vampire, dialog_list[9], female_voice)
	yield(self, "step_ended")

	speak_for(hero, dialog_list[10], male_voice)
	yield(self, "step_ended")

	speak_for(vampire, dialog_list[11], female_voice)
	yield(self, "step_ended")

	move_actor(hero, Vector2(20, 0))
	yield(self, "step_ended")

	Manager.level.switch_to(Areas.TestLevel0)
