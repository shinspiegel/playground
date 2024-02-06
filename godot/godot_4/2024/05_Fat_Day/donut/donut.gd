class_name Donuts extends RigidBody2D

var art_list = [
	preload("res://assets/used/donuts/01-SimpleDonut.png"),
	preload("res://assets/used/donuts/02-GlazedSimpleDonut.png"),
	preload("res://assets/used/donuts/03-RedDonut.png"),
	preload("res://assets/used/donuts/04-GlazedRedDonut.png"),
	preload("res://assets/used/donuts/05-PurpleDonut.png"),
	preload("res://assets/used/donuts/06-GlazedPurpleDonut.png"),
	preload("res://assets/used/donuts/07-BrownDonut.png"),
	preload("res://assets/used/donuts/08-GlazedBrownDonut.png"),
	preload("res://assets/used/donuts/09-SmoresDonut.png"),
	preload("res://assets/used/donuts/10-EasterDonut.png"),
	preload("res://assets/used/donuts/11-MatchaDonut.png"),
	preload("res://assets/used/donuts/12-CookieDonut.png"),
	preload("res://assets/used/donuts/13-SpookyDonut.png"),
	preload("res://assets/used/donuts/14-WhiteSprinkleDonut.png"),
	preload("res://assets/used/donuts/15-RedVelvetDonut.png"),
	preload("res://assets/used/donuts/16-MeMSprinklesDonut.png"),
	preload("res://assets/used/donuts/17-UbeFrostingDonut.png"),
	preload("res://assets/used/donuts/18-XmasDonut.png"),
	preload("res://assets/used/donuts/19-CookieCreamDonut.png"),
	preload("res://assets/used/donuts/20-ChocolateFrostingDonut.png"),
	preload("res://assets/used/donuts/21-CreamDonut.png"),
	preload("res://assets/used/donuts/22-StrawberryDonut.png"),
	preload("res://assets/used/donuts/23-MintDonut.png"),
	preload("res://assets/used/donuts/24-OrangeChocolateDonut.png"),
	preload("res://assets/used/donuts/25-SprinklesChocolateDonut.png"),
	preload("res://assets/used/donuts/26-SimpleMochi.png"),
	preload("res://assets/used/donuts/27-GlazedSimpleMochi.png"),
	preload("res://assets/used/donuts/28-RedMochi.png"),
	preload("res://assets/used/donuts/29-GlazedRedMochi.png"),
	preload("res://assets/used/donuts/30-PurpleMochi.png"),
	preload("res://assets/used/donuts/31-GlazedPurpleMochi.png"),
	preload("res://assets/used/donuts/32-BrownMochi.png"),
	preload("res://assets/used/donuts/33-GlazedBrownMochi.png"),
	preload("res://assets/used/donuts/34-StrawberryMochi.png"),
	preload("res://assets/used/donuts/35-SpookyMochi.png"),
	preload("res://assets/used/donuts/36-OrangeChocolateMochi.png"),
	preload("res://assets/used/donuts/37-KinderMochi.png"),
	preload("res://assets/used/donuts/38-RedVelvetMochi.png"),
	preload("res://assets/used/donuts/39-SesameMochi.png"),
	preload("res://assets/used/donuts/40-UbeMochi.png"),
	preload("res://assets/used/donuts/41-MatchaMochi.png"),
	preload("res://assets/used/donuts/42-SimpleFilled.png"),
	preload("res://assets/used/donuts/43-GlazedSimpleFilled.png"),
	preload("res://assets/used/donuts/44-ChocolateFilled.png"),
	preload("res://assets/used/donuts/45-StrawberryFilled.png"),
	preload("res://assets/used/donuts/46-KinderFilled.png"),
]

@export var player_area: Area2D
@export var sprite: Sprite2D


func _ready() -> void:
	player_area.body_entered.connect(on_body_enter)
	_randomize_art()


func on_body_enter(node: Node2D) -> void:
	if node is Player:
		GameManager.add_donuts()
		queue_free()


func _randomize_art() -> void:
	art_list.shuffle()
	sprite.texture = art_list.front()

