extends Node

@export_dir var path: String

var _loaded: Dictionary[String, R_Level] = {}

func _ready() -> void:
	var array: Array = SD_FileSystem.get_all_files_with_extension_from_directory(path, SD_FileExtensions.EC_RESOURCE)
	while !array.is_empty():
		var path: String = array[0]
		var level: R_Level = load(path)
		_loaded[level.get_code()] = level
		SD_Console.i().write_info("map loaded: %s" % path)
		array.erase(path)

func get_by_code(code: String) -> R_Level:
	return _loaded.get(code)

func load_scene(level: R_Level) -> PackedScene:
	return load(path.path_join(level.path) + ".tscn")
