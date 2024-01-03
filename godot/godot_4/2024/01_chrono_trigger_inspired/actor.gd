class_name Actor extends CharacterBody2D

signal turn_started()
signal turn_ended()
signal selected()
signal focus()
signal damaged(amount: int)
signal health_changed(health: int, max_health: int)

@export var move_speed = 30000.0
@export var friction = 0.3

@export_group("Battle data", "stat_")
@export var stat_actions_container: Node2D
@export var stat_max_hit_points: int = 10
@export var stat_hit_points: int = 10
@export var stat_attack: int = 10
@export var stat_defense: int = 5
@export var stat_speed: int = 10
@export_range(0.0, 2.0, 0.1) var stat_damage_variation: float = 0.1
@export_range(0.1, 1.0, 0.1) var stat_crit_chance: float = 0.1
@export_range(1.0, 5.0, 0.1) var stat_crit_bonus: float = 1.5

@onready var target_control: BaseButton = %SelectNode
@onready var anim_player: ActorAnimPlayer = %AnimPlayer

var action_list: Array[CombatAction] = []
var anim_state_machine: AnimationNodeStateMachinePlayback

func _ready() -> void:
	#anim_state_machine = anim_tree.get("parameters/playback")

	for node in stat_actions_container.get_children():
		if node is CombatAction:
			action_list.append(node)

	target_control.hide()
	target_control.pressed.connect(func(): selected.emit())
	target_control.focus_entered.connect(func(): focus.emit())


func grab_focus() -> void:
	target_control.grab_focus()


func show_target() -> void:
	target_control.show()


func hide_target() -> void:
	target_control.hide()


func act_turn() -> void:
	print_debug("WARN::Should implemente this on the inherited class. Remeber to emit 'start_turn' signal.")
	turn_started.emit()


func end_turn() -> void:
	print_debug("WARN::Should implemente this on the inherited class. Remeber to emit 'end_turn' signal.")
	turn_ended.emit()


func get_focus_path() -> NodePath:
	return target_control.get_path()


func set_neighbor(next: NodePath, prev: NodePath) -> void:
	target_control.set_focus_previous(prev)
	target_control.set_focus_neighbor(SIDE_TOP, prev)
	target_control.set_focus_neighbor(SIDE_LEFT, prev)

	target_control.set_focus_next(next)
	target_control.set_focus_neighbor(SIDE_BOTTOM, next)
	target_control.set_focus_neighbor(SIDE_RIGHT, next)


func attack_target(target: Actor) -> void:
	var damage_variation = float(stat_attack * stat_damage_variation)
	var damage = randi_range(stat_attack - damage_variation, stat_attack + damage_variation)

	if randf_range(0.0, 1.0) < stat_crit_chance:
		damage += damage * stat_crit_bonus

	target.receive_damage(damage)
	turn_ended.emit()


func receive_damage(damage: int) -> void:
	var total_damage = clampi(damage - stat_defense, 1, damage - stat_defense)
	damaged.emit(total_damage)
	health_changed.emit()
	stat_hit_points -= total_damage


# Private Methods


func __change_health(amount: int) -> void:
	stat_hit_points = clampi(stat_hit_points + amount, 0, stat_max_hit_points)
	health_changed.emit(stat_hit_points, stat_max_hit_points)


