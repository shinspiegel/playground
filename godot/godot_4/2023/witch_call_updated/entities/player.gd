class_name Witch extends CharacterBody2D

@export var run_data: RunData
@export var shoot_scene: PackedScene
@export var shoot_mana_cost: float = 10
@export var speed = 200.0
@export var direction: float = 0.0
@export var shoot: bool = false

@onready var shoot_colddown: Timer = $ShootColddown
@onready var shoot_pos: Marker2D = $ShootPos
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	passive_restore_mana(delta)


func _physics_process(_delta: float) -> void:
	check_direction_keys()
	check_shoot_keys()
	
	apply_direction()
	apply_animation()
	apply_shoot()
	
	move_and_slide()


func apply_direction() -> void:
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed/10)


func apply_animation() -> void:
	if velocity.x < 0:
		animation_player.play("left")
	elif velocity.x > 0:
		animation_player.play("right")
	else: 
		animation_player.play("fly")


func apply_shoot() -> void:
	if shoot and shoot_colddown.is_stopped() and run_data.mana_bar > shoot_mana_cost:
		run_data.consume_mana(shoot_mana_cost)
		shoot_colddown.start()
		
		var shoot_node = shoot_scene.instantiate()
		get_parent().add_child(shoot_node)
		shoot_node.global_position = shoot_pos.global_position


func check_direction_keys() -> void:
	direction = Input.get_axis("left", "right")


func check_shoot_keys() -> void:
	shoot = Input.is_action_pressed("shot")


func passive_restore_mana(delta: float) -> void:
	run_data.restore_mana(delta * run_data.mana_recovery_rate)
