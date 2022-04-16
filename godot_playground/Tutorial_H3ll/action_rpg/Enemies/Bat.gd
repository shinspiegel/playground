extends KinematicBody2D

const ACCELERATION = 250
const MAX_SPEED = 50
const FRICTION = 150

export(int) var MAX_LIFE = 2
export(PackedScene) var DEATH_SCENE

enum {IDLE, WANDER, CHASE}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var life = MAX_LIFE setget life_change
onready var state = IDLE
onready var playerDetection = $PlayerDetection
onready var animatedSprite = $AnimatedSprite
onready var hitBox = $Hitbox
onready var softCollision = $SoftCollision
onready var wanderingController = $WanderingController
onready var player = null

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	should_seek()
	
	match state:
		IDLE: idle_state(delta)
		WANDER: wander_state(delta)
		CHASE: chase_state(delta)
	
	animatedSprite.flip_h = velocity.x < 0
	bats_softcollision(delta)
	velocity = move_and_slide(velocity)
	

func idle_state(delta: float):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	should_change_state([IDLE, WANDER])


func wander_state(delta: float):
	var direction = global_position.direction_to(wanderingController.target_position)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	set_vector_positions(direction)
	should_change_state([IDLE, WANDER])


func chase_state(delta: float):
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		set_vector_positions(direction)
	else:
		should_change_state([IDLE, WANDER])
	

func bats_softcollision(delta):
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400


func should_seek():
	if playerDetection.can_see_player():
		player = playerDetection.PLAYER
		state = CHASE
	else:
		player = null
		

func should_change_state(new_state_list:Array):
	if wanderingController.time_left() <= 0:
		state = pick_random_state(new_state_list)
		wanderingController.set_wander_timer(rand_range(1, 3))


func pick_random_state(state_list:Array):
	state_list.shuffle()
	return state_list.pop_front()


func life_change(value):
	life = value
	if life <= 0:
		create_effect()
		queue_free()


func create_effect():
	var effect = DEATH_SCENE.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position

func set_vector_positions(vector: Vector2):
	hitBox.POSITION = vector

func _on_Hurtbox_area_entered(area):
	self.life -= area.DAMAGE
	knockback = area.POSITION * area.IMPACT
