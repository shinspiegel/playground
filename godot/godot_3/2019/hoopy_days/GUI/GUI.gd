extends CanvasLayer

func _on_Player_life_change(lifes):
	$Control/TextureRect/HBoxContainer/LifeCounts.text = str(lifes)

func _on_Player_coin_change(coins):
	$Control/TextureRect/HBoxContainer/CoinCounts.text = str(coins)
