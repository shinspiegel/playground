extends Area2D

export(PackedScene) var HitEffect
export(PackedScene) var HurtSound
export(NodePath) var SpriteToBlinkPath
export(bool) var showHit = true
export(bool) var makeSound = true
export(bool) var shouldBlink = true

onready var hitPosition = $HitPosition
onready var inviTimer = $InviTimer
onready var blinkTimer = $BlinkTimer
onready var shape = $CollisionShape2D

var sprite = null

func _ready():
	if shouldBlink: sprite = get_node(SpriteToBlinkPath)

func create_effect(): 
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = hitPosition.global_position
	
	
func create_sound_effect(): 
	var sound = HurtSound.instance()
	var main = get_tree().current_scene
	main.add_child(sound)
	
	
func create_blink_effect():
	if not inviTimer.is_stopped():
		blinkTimer.start()
		sprite.visible = !sprite.visible
		yield(blinkTimer, "timeout")
		create_blink_effect()


func set_hurtbox_enable(value:bool):
	set_deferred("monitorable", value)
	set_deferred("monitoring", value)
	shape.set_deferred("disabled", !value)

func _on_Hurtbox_area_entered(_area):
	if(inviTimer.is_stopped()):
		set_hurtbox_enable(false)
		inviTimer.start()
		
		if showHit: create_effect()
		if makeSound: create_sound_effect()
		if shouldBlink: create_blink_effect()

func _on_InviTimer_timeout():
	sprite.visible = true
	set_hurtbox_enable(true)
	inviTimer.stop()
	
