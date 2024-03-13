class_name CutSceneTargetable extends CutSceneBase

@export var index: int = 0
@export var is_party: bool

var actor: Actor : get = get_actor


func get_actor() -> Actor:
	if is_party:
		return PartyManager.at(index)

	return CutSceneManager.at(index)
