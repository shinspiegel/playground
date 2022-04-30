extends CanvasLayer

export(PackedScene) var fullHeartScene
export(PackedScene) var emptyHeartScene

onready var lifeholder: HBoxContainer = $FullArea/LifeHolder
onready var coinCounter: Label = $FullArea/VBoxContainer/CoinHolder/CoinCounter
onready var manaCounter: Label = $FullArea/VBoxContainer/ManaHolder/ManaCounter

func _ready():
	update_life(0,0)
	update_coin(0)
	update_mana(0)


func update_coin(value:int):
	coinCounter.text = str(value)


func update_mana(value:int):
	manaCounter.text = str(value)


func update_life(life: int, max_life: int):
	var fullHeartAmount = life
	var emptyHeartAmount = max_life - life
	
	for item in lifeholder.get_children():
		item.queue_free()
	
	for amount in fullHeartAmount:
		var scene = fullHeartScene.instance()
		lifeholder.add_child(scene)
	
	for amout in emptyHeartAmount:
		var scene = emptyHeartScene.instance()
		lifeholder.add_child(scene)


func _on_Player_life_changed(life, max_life):
	update_life(life, max_life)


func _on_Player_coin_changed(coin):
	update_coin(coin)


func _on_Player_mana_changed(mana):
	update_mana(mana)
