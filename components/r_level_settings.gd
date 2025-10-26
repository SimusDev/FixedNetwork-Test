extends Resource
class_name R_LevelSettings

static var _current: R_LevelSettings

static func get_current() -> R_LevelSettings:
	return _current

func _level_loaded() -> void:
	_current = self
