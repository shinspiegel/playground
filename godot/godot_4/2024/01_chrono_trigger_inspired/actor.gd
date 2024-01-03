@tool
class_name Actor extends CharacterBody2D

signal turn_started()
signal turn_ended()
signal selected()
signal focus()

@export var actor_data: ActorData
@export var move_speed = 30000.0
@export var friction = 0.3

@onready var target_control: BaseButton = %SelectNode
@onready var anim_player: ActorAnimPlayer = %AnimPlayer
@onready var action_container: Node2D = %ActionList
@onready var art_sprite: Sprite2D = %Art

var action_list: Array[CombatAction] = []


func _ready() -> void:
	name = actor_data.name
	art_sprite.texture = actor_data.actor_texture

	if not Engine.is_editor_hint(): # Only in game
		actor_data = actor_data.duplicate(true)
		actor_data.die.connect(on_actor_die)

		for node in action_container.get_children():
			if node is CombatAction:
				action_list.append(node)

		target_control.hide()
		target_control.pressed.connect(func(): selected.emit())
		target_control.focus_entered.connect(func(): focus.emit())


func get_focus_path() -> NodePath: return target_control.get_path()
func grab_focus() -> void: target_control.grab_focus()
func show_target() -> void: target_control.show()
func hide_target() -> void: target_control.hide()


func act_turn() -> void:
	print_debug("WARN::Should implemente this on the inherited class. Remeber to emit 'start_turn' signal.")
	turn_started.emit()


func actor_death() -> void:
	print_debug("INFO::Actor death. Using defatul behaviuor")
	turn_ended.emit()
	queue_free()


func end_turn() -> void:
	print_debug("INFO::Using default behaviuor for 'end_turn'. Remeber to emit 'end_turn' signal.")
	turn_ended.emit()


func set_neighbor(next: NodePath, prev: NodePath) -> void:
	target_control.set_focus_previous(prev)
	target_control.set_focus_neighbor(SIDE_TOP, prev)
	target_control.set_focus_neighbor(SIDE_LEFT, prev)

	target_control.set_focus_next(next)
	target_control.set_focus_neighbor(SIDE_BOTTOM, next)
	target_control.set_focus_neighbor(SIDE_RIGHT, next)


func receive_damage(damage: Damage) -> void:
	damage.apply_defense(actor_data.defense)
	actor_data.receive_damage(damage.amount)


func on_actor_die() -> void:
	actor_death()
