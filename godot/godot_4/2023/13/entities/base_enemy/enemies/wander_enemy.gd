extends BaseEnemy

@onready var state_machine: StateMachine = $StateMachine
@onready var label: Label = $Label


func _ready() -> void:
	super._ready()
	state_machine.state_changed.connect(on_state_change)
	label.text = "State::[%s]" % [state_machine.get_current_state().name]


func on_state_change(state: String) -> void:
	label.text = "State::[%s]" % [state]
