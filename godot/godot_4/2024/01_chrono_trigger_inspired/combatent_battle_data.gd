class_name CombatentBattleData extends Control

@onready var name_label: Label = %NameLabel
@onready var health_bar: ProgressBar = %HealthBar
@onready var health_number: Label = %NumberValues
@onready var background: ColorRect = %Background


func _ready() -> void:
	background.hide()


func enable_background() -> void: background.show()
func disable_background() -> void: background.hide()


func set_actor(actor: Actor) -> void:
	name_label.text = actor.name

	actor.actor_data.health_changed.connect(__update_bar)
	actor.turn_started.connect(enable_background)
	actor.turn_ended.connect(disable_background)

	__update_bar(actor.actor_data.hit_points, actor.actor_data.max_hit_points)


# Private Methods


func __update_bar(value: int, max_value: int) -> void:
	health_bar.max_value = value
	health_bar.value = max_value
	health_number.text = "%s / %s" % [value, max_value]

