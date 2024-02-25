class_name Actor extends CharacterBody2D

@export var actor_data: ActorData

@onready var base_sprite: Sprite2D = %BaseSprite
@onready var body_sprite: Sprite2D = %BodySprite
@onready var head_sprite: Sprite2D = %HeadSprite
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var hand_pos: Marker2D = %HandPos


func _ready() -> void:
	apply_textures_from_data()


func apply_damage(damage: Damage) -> void:
	actor_data.deal_damage(damage)
	BattleManager.target_damaged.emit(self, damage)


func apply_textures_from_data() -> void:
	if not actor_data: push_error("missing actor data")
	if actor_data.base_texture:
		base_sprite.texture = actor_data.base_texture
	if actor_data.body_texture:
		body_sprite.texture = actor_data.body_texture
	if actor_data.head_texture:
		head_sprite.texture = actor_data.head_texture


func play_idle(dir: Vector2 = Vector2.ZERO) -> void:
	play_animation("idle", dir.angle())


func play_move(dir: Vector2 = Vector2.ZERO) -> void:
	play_animation("move", dir.angle())


func play_animation(anim_name: String, angle_rad: float) -> void:
	var dir_name := "down"

	if angle_rad >= -PI/4 and angle_rad < PI/4:
		dir_name = "right"
	elif angle_rad >= PI/4 and angle_rad < 3*PI/4:
		dir_name = "down"
	elif angle_rad >= -3*PI/4 and angle_rad < -PI/4:
		dir_name = "up"
	else:
		dir_name = "left"

	animation_player.play("%s_%s"% [anim_name, dir_name])


func get_cursor_position() -> Vector2:
	return hand_pos.get_global_transform_with_canvas().origin


func get_actions() -> Array[ActionCommand]:
	return actor_data.actions


func get_attack(stat: String) -> int:
	var bonus: int = 0

	match stat:
		"str": bonus = actor_data.stat_str_mod
		"dex": bonus = actor_data.stat_dex_mod
		"con": bonus = actor_data.stat_con_mod
		"int": bonus = actor_data.stat_int_mod
		"wis": bonus = actor_data.stat_wis_mod
		"cha": bonus = actor_data.stat_cha_mod
		_: bonus = 0

	return randi_range(0, 20) + bonus + actor_data.prof_bonus


func get_armor() -> int:
	var value = 10
	var armor = actor_data.equip_armor

	if armor and armor is ArmorEquipment:
		if armor.apply_dex:
			armor += actor_data.stat_dex_mod

		armor += armor.bonus

	return value

