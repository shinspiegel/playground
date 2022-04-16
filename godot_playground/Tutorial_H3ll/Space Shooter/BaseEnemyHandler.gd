extends Node2D

export (int) var level := 1

func _ready() -> void:
	update_level_monster()

func update_level_monster():
	var monster_list = get_children()
	
	for monster in monster_list:
		monster.SPEED += level
		monster.ARMOR += int(level / 3)
