extends Node
class_name ObjectHandler

@export var _default_tab: R_ObjectTab
@export_dir var path_tabs: String
@export_dir var path_objects: String

var _loaded: Array[R_Object] = []
var _tabs: Array[R_ObjectTab] = []

func _ready() -> void:
	process_priority = 1
	
	if not path_tabs.is_empty():
		for path in SD_FileSystem.get_all_files_with_extension_from_directory(path_tabs, SD_FileExtensions.EC_RESOURCE):
			var resource: Resource = load(path)
			if resource is R_ObjectTab:
				_tabs.append(resource)
				resource.register()
	
	if _default_tab:
		R_ObjectTab._default = _default_tab
	
	if not path_objects.is_empty():
		for path in SD_FileSystem.get_all_files_with_extension_from_directory(path_objects, SD_FileExtensions.EC_RESOURCE):
			var resource: Resource = load(path)
			if resource is R_Object:
				_loaded.append(resource)
				resource.register()
	

func _exit_tree() -> void:
	for object in _loaded:
		object.unregister()
	
	for tab in _tabs:
		tab.unregister()
