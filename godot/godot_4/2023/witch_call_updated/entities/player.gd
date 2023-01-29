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
@onready var invencibility_coldown: Timer = $InvencibilityColdown
@onready var hurt_box: HurtBox = $HurtBox

var witch: Witch

func _ready() -> void:
	hurt_box.hit_received.connect(on_receive_hit)
	invencibility_coldown.timeout.connect(on_invencibility_timeout)

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


func on_invencibility_timeout() -> void:
	set_modulate(Color(1,1,1,1))


func on_receive_hit(hit: HitBox) -> void:
	if invencibility_coldown.is_stopped():
		run_data.reduce_life(hit.get_damage_amount())
		invencibility_coldown.start()
		set_modulate(Color(1,1,1,0.2))
