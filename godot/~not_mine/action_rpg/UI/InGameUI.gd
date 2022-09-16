extends Control

const pixelWitdh = 15

export (NodePath) var PlayerNode

var maxLife = 0 setget max_life_change
var life = 0 setget life_change
var player = null

onready var empty = $Empty
onready var full = $Full

func _ready():
	player = get_node(PlayerNode)
	self.maxLife = player.MAX_LIFE
	self.life = player.life


func life_change(value):
	life = value
	handle_label()


func max_life_change(value):
	maxLife = value
	handle_label()


func handle_label():
	full.rect_size.x = life * pixelWitdh
	empty.rect_size.x = maxLife * pixelWitdh
	

func _on_Player_life_change(life_value):
	self.life = life_value
