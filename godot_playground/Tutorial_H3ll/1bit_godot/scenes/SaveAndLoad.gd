extends Node

const SAVE_DATA_PATH = "res://save_data.json"

var default_save_data = {
	highscore = 10,
}

func save_date_to_file(save_data):
	var json_string = to_json(save_data)
	var file = File.new()
	file.open(SAVE_DATA_PATH, File.WRITE)
	file.store_line(json_string)
	file.close()

func load_data_from_file():
	var file = File.new()
	
	if not file.file_exists(SAVE_DATA_PATH):
		return default_save_data
	
	file.open(SAVE_DATA_PATH, File.READ)
	var save_data = parse_json(file.get_as_text())
	return save_data
