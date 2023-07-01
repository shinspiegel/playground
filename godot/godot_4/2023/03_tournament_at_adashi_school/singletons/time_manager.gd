extends Node

signal advanced_time()
signal reseted_time()
signal advanced_weekday()

enum WeekDays { monday, tuesday, wednesday, thursday, friday, tournament_day}

var current_day: WeekDays = WeekDays.monday
var current_time: int = 0


func _ready() -> void:
	RoomManager.changed_room.connect(advance_time)


func advance_time() -> void:
	current_time += 1
	advanced_time.emit()


func advance_week_day() -> void:
	match current_day:
		WeekDays.monday:
			current_day = WeekDays.tuesday
		WeekDays.tuesday:
			current_day = WeekDays.wednesday
		WeekDays.wednesday:
			current_day = WeekDays.thursday
		WeekDays.friday:
			current_day = WeekDays.tournament_day
	
	current_time = 0
	reseted_time.emit()
	advanced_weekday.emit()
