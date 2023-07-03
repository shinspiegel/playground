extends Control

var playerWords = []
var currentStory

onready var DisplayText = get_node("VBoxContainer/DisplayText") 
onready var PlayerText = get_node("VBoxContainer/HBoxContainer/PlayerText")

func _ready():
	setStory()
	
	DisplayText.text = "Let's play a game, could you please..."
	checkPlayerWords()
	PlayerText.grab_focus()

func setStory():
	randomize()
	
#	//Alternative way for getting from external json file
#	var stories = getFromJSON("StoryBook.json")
#	currentStory = stories[randi() % stories.size()]	
	
	var stories = get_node("Storybook").get_child_count()
	var selected_stories = randi() % stories
	currentStory.story = get_node("Storybook").get_child(selected_stories).prompts
	currentStory.prompt = get_node("Storybook").get_child(selected_stories).story

func AddPlayerWords():
	if PlayerText.text == "":
		return
	
	playerWords.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	PlayerText.grab_focus()
	checkPlayerWords()

func isStoryDone():
	return playerWords.size() == currentStory.prompt.size()

func checkPlayerWords():
	if isStoryDone():
		endGame()
	else:
		promptPlayer()

func tellStory():
	DisplayText.text = currentStory.story % playerWords

func promptPlayer():
	DisplayText.text += "May i have " + currentStory.prompt[playerWords.size()] + " please?"

func endGame():
	PlayerText.queue_free()
	get_node("VBoxContainer/HBoxContainer/TextureButton/Label").text = "<"
	tellStory()

func getFromJSON(fileName):
	var file = File.new()
	file.open(fileName, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data



############## SIGNALS
func _on_PlayerText_text_entered(new_text):
	AddPlayerWords()
	PlayerText.grab_focus()
	
func _on_TextureButton_button_up():
	if isStoryDone():
		return get_tree().reload_current_scene()
	
	AddPlayerWords()
	PlayerText.grab_focus()