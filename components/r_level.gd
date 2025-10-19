extends Resource
class_name R_Level

@export var name: String
@export_multiline var description: String
@export var path: String
@export var settings: R_LevelSettings

func _loaded() -> void:
	if not settings:
		settings = R_LevelSettings.new()

func _changed_in_game() -> void:
	pass

func get_code() -> String:
	return name
