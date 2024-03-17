class_name CutSceneWait extends CutSceneBase

@export_range(0.1, 5.0, 0.1) var seconds: float


func execute() -> void:
	CutSceneManager.wait(seconds).timeout.connect(func(): ended.emit())