extends Node

var player = {
	"life": null,
	"mana": null,
	"coins": null,
}

func save_player_data(data):
	print("INFO: saved player data")
	player.life = data.life
	player.mana = data.mana
	player.coins = data.coins


func get_player_data():
	print("INFO: Get player data")
	return player
