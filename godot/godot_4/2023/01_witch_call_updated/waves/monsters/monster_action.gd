class_name MonsterAction extends Resource

## It set to zero, will consider infinite
@export_range(0.0, 10.0, 0.1) var duration: float = 1.0
@export var type: ActionType = ActionType.wait

enum ActionType {
	move,
	wait,
	special,
}
