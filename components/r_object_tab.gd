extends Resource
class_name R_ObjectTab

@export var name: StringName

static var _default: R_ObjectTab

static var _references: Dictionary[StringName, R_ObjectTab] = {}
static var _reference_list: Array[R_ObjectTab] = []

static func get_references() -> Dictionary[StringName, R_ObjectTab]:
	return _references

static func get_reference_list() -> Array[R_ObjectTab]:
	return _reference_list

func register() -> void:
	if _references.has(name):
		name += "_"
	
	_references[name] = self
	_reference_list.append(self)
	
	SD_Console.i().write_info("object tab registered: %s" % name)

func unregister() -> void:
	_references.erase(name)
	_reference_list.erase(self)
	
	SD_Console.i().write_warning("object tab unregistered: %s" % name)

static func get_default() -> R_ObjectTab:
	return _default
