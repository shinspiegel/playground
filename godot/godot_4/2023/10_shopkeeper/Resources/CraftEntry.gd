class_name CraftEntry extends Resource


@export_group("Data", "data_")
@export var data_name: String = "Craft Name"


@export_group("Success Criteria", "suc_")
@export var suc_required: int = 3
@export_range(0.1, 3.0, 0.1) var suc_multiplier: float = 1.0
@export var suc_fail_limit: int = 2


@export_group("Difficult Settings", "diff_")
@export_range(1.0, 10.0, 0.5) var diff_slider_speed: float = 2
@export_range(0.0, 10.0, 0.5) var diff_good: float = 1
@export_range(0.0, 10.0, 0.5) var diff_ok: float = 4
@export_range(0.0, 10.0, 0.5) var diff_bad: float = 9
@export_range(0.0, 10.0, 0.5) var diff_fail: float = 10

@export_group("Target Item")
@export var target_item: InventoryItem
