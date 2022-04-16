extends Area2D

onready var DAMAGE := 1
onready var SPEED := 70
onready var VERTICAL_SPEED := 10
onready var ANIM := get_node("AnimatedSprite")

var Direction := 1
var OwnerID : int 

func _ready():
	ANIM.play("Spell")

func _process(delta):
	position.x += SPEED * Direction * delta
	position.y -= VERTICAL_SPEED * delta

func set_diretion(value):
	Direction = value

func set_ownerID(id):
	OwnerID = id

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _on_SpellEffect_body_entered(body):
	if body.get_canvas_item().get_id() != OwnerID:
		if body.has_method("receive_damage"):
			body.receive_damage(DAMAGE)