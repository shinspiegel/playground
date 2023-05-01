class_name MonsterBase extends Node2D 

@export var hit_points: int = 2
@export var speed: float = 100.0
@export var score: int = 10
@export var death_animation: PackedScene
@export var monster_hurt_sfx: AudioStream
@export var monster_actions: Array[MonsterAction] = []

@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hurt_box: HurtBox = $HurtBox
@onready var health_bar: TextureProgressBar = $Control/TextureProgressBar
@onready var action_duration: Timer = $ActionDuration
@onready var loot_drop: LootDrop = $LootDrop


func _ready() -> void:
	action_duration.timeout.connect(on_action_timeout)
	visible_notifier.screen_exited.connect(func(): queue_free())
	hurt_box.hit_received.connect(receive_hit)
	health_bar.max_value = hit_points
	health_bar.value = hit_points
	
	if monster_actions.size() >= 2 and monster_actions[0].duration > 0:
		action_duration.start(monster_actions[0].duration)


func _physics_process(delta: float) -> void:
	match monster_actions[0].type:
		MonsterAction.ActionType.wait:
			pass
		MonsterAction.ActionType.move:
			apply_movement(delta)
		MonsterAction.ActionType.special:
			apply_special(delta)


func apply_movement(delta: float) -> void:
	position.y += speed * delta


func apply_special(_delta: float) -> void:
	print_debug("WARN:: Special not implemented")


func receive_hit(hit_box: HitBox) -> void:
	hit_points -= hit_box.damage.amount
	
	health_bar.value = hit_points
	
	if hit_points <= 0:
		die()
	else:
		SignalBus.play_sfx.emit(monster_hurt_sfx)


func spawn_animation_effect() -> void:
	var death_effect = death_animation.instantiate()
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position


func die() -> void:
	loot_drop.call_deferred("drop_random")
	spawn_animation_effect()
	SignalBus.monster_die.emit(self)
	queue_free()
 

func on_action_timeout() -> void:
	if monster_actions.size() <= 1:
		return
	
	monster_actions.pop_front()
	
	if monster_actions[0].duration > 0:
		action_duration.start(monster_actions[0].duration)
