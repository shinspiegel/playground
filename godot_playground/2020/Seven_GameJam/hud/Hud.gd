extends CanvasLayer

export(int) var max_life := 3
export(int) var life := 3
export(PackedScene) var HeartIcon
export(PackedScene) var HeartEmpty

onready var lifeContainer = $Control/LifeContainer
onready var coinsCounter = $Control/VBoxContainer/CoinContainer/Label
onready var obsCounter = $Control/VBoxContainer/OrbContainer/Label

func _ready() -> void:
	update_hearts()
	update_coins(0)


func update_coins(value):
	coinsCounter.text = str(value)


func update_orbs(value):
	obsCounter.text = str(value)


func update_hearts():
	for node in lifeContainer.get_children():
		node.queue_free()
	
	for n in life:
		create_heart()
	
	for n in max_life - life:
		create_empty_heart()


func create_heart():
	var instance = HeartIcon.instance()
	lifeContainer.add_child(instance)


func create_empty_heart():
	var instance = HeartEmpty.instance()
	lifeContainer.add_child(instance)


func _on_Player_life_change(received_life:int, received_max_life:int) -> void:
	life = received_life
	max_life = received_max_life
	update_hearts()


func _on_Player_changed_collectables(collectable_dict) -> void:
	update_coins(collectable_dict.coins)
	update_orbs(collectable_dict.orbs)
