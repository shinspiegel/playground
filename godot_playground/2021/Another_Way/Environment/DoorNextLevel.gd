extends Area2D

export(PackedScene) var nextLevel
export(String) var message

onready var label: Label = $Node2D/Label
onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _input(event):
	if event.is_action_pressed("jump") and is_player_in():
		var playerData = get_player_data()
		LevelManager.save_player_data(playerData)
		change_level()


func get_player_data():
	var player = get_tree().current_scene.find_node("Player")
	
	return {
		"life": player.life,
		"mana": player.mana,
		"coins": player.coins,
	}

func is_player_in() -> bool:
	for area in get_overlapping_bodies():
		if area is Player:
			return true
	return false


func change_level():
	get_tree().change_scene_to(nextLevel)


func _on_DoorNextLevel_body_entered(body):
	if body is Player:
		animationPlayer.play("FadeIn")


func _on_DoorNextLevel_body_exited(body):
	if body is Player:
		animationPlayer.play("FadeOut")
