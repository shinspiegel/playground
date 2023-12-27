extends Actor

@export var game_state: GameState
@export var camera: Camera2D

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D


func _ready() -> void:
	if camera:
		remote_transform_2d.set_remote_node(camera.get_path())


func _physics_process(delta: float) -> void:
	if game_state.is_world():
		var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction.normalized()

		if direction.is_zero_approx():
			velocity = lerp(velocity, Vector2.ZERO, friction)
		else:
			velocity = lerp(velocity, direction * speed * delta, friction)

	if game_state.is_battle():
		velocity = Vector2.ZERO

	move_and_slide()
