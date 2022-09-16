extends CharacterBody2D
class_name Character


@export_range(1, 200, 1) var SPEED = 120
@export_range(1, 10, 1) var MAX_LIFE = 5
@export_range(0, 100, 1) var GRAVITY = 20
@export_dir var START_STATE_PATH
 var facing_right := true

var STATE_MAP = {}
var life : int
var motion := Vector2()
var current_state = null
var last_state : String
