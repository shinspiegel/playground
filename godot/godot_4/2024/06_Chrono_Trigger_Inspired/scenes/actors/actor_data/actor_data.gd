class_name ActorData extends Resource

const LEVEL_EXP = [ 
#   1  2    3    4     5
	0, 300, 900, 2700, 6500,
#   6      7      8      9      10
	14000, 23000, 34000, 48000, 64000,
#   11     12      13      14      15
	85000, 100000, 120000, 140000, 165000,
#   16      17      18      19      20
	195000, 225000, 265000, 305000, 355000,
]

signal level_up()
signal player_died()

@export var level: int = 1
@export var experience: int = 0
var prof_bonus: get = get_proficiency_bonus


@export_group("Class Data", "class_")
@export var class_hit_dice: int = 6
var class_hit_points: get = get_class_hit_points
var class_current_hp: int = 10
var class_initiative: get = get_class_initiative


@export_group("Stats", "stat_")
@export var stat_str: int = 10
@export var stat_dex: int = 10
@export var stat_con: int = 10
@export var stat_int: int = 10
@export var stat_wis: int = 10
@export var stat_cha: int = 10
var stat_str_mod: get = get_str_mod
var stat_dex_mod: get = get_dex_mod
var stat_con_mod: get = get_con_mod
var stat_int_mod: get = get_int_mod
var stat_wis_mod: get = get_wis_mod
var stat_cha_mod: get = get_cha_mod


@export_group("Equipment", "equip_")
@export var equip_left: Equipment
@export var equip_right: Equipment
@export var equip_armor: Equipment

var speed: get = get_speed
var friction: int = 10

@export_group("Texture")
@export var base_texture: Texture2D
@export var body_texture: Texture2D
@export var head_texture: Texture2D


@export_group("Follow", "follow_")
@export_range(100, 300, 5) var follow_min_distance: int = 50
@export_range(0.0, 2.0, 0.05) var follow_ratio: float = 1.0
@export_range(0, 100, 5) var follow_distance: int = 20
@export_range(0, 100, 5) var follow_angle: int = 45


@export_group("Actions")
@export var actions: Array[ActionCommand] = []


func _init() -> void:
	class_current_hp = class_hit_points


func gain_experience(xp: int) -> void:
	experience += xp
	var level_count := 1
	
	for x in LEVEL_EXP:
		if experience > x: level_count += 1
		else: break
	
	if level_count > level:
		level = level_count
		level_up.emit()


func deal_damage(dmg: Damage) -> void:
	class_current_hp = clampi(class_current_hp - dmg.amount, 0, class_hit_points)
	if class_current_hp <= 0:
		player_died.emit()


func get_mod(val: int) -> int:
	return floor((float(val) - 10.0) / 2)


func get_proficiency_bonus() -> int:
	return 1 + ceili(float(level) / 4)


func get_class_hit_points() -> int:
	return stat_con + (level + class_hit_dice)


func get_str_mod() -> int: 
	return get_mod(stat_str)


func get_dex_mod() -> int: 
	return get_mod(stat_dex)


func get_con_mod() -> int: 
	return get_mod(stat_con)


func get_int_mod() -> int: 
	return get_mod(stat_int)


func get_wis_mod() -> int: 
	return get_mod(stat_wis)


func get_cha_mod() -> int: 
	return get_mod(stat_cha)


func get_speed() -> int:
	return 500 + maxi(stat_str, stat_dex)


func get_class_initiative() -> int:
	return randi_range(1, 20) + stat_dex_mod

