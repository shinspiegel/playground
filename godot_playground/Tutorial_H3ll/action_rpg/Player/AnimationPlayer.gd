extends AnimationPlayer

signal finishedAnimation

func finishedAnimation(animation:String):
	emit_signal("finishedAnimation", animation)

