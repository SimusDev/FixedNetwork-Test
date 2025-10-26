extends Resource
class_name R_Object

static var _references: Dictionary[String, R_Object] = {}
static var _reference_list: Array[R_Object] = []

@export var id: String
@export var tab: R_ObjectTab

func get_default_tab() -> R_ObjectTab:
	return R_ObjectTab.get_default()

static func get_references() -> Dictionary[String, R_Object]:
	return _references

static func get_reference_list() -> Array[R_Object]:
	return _reference_list

static func find_by_id(obj_id: String) -> R_Object:
	return _references.get(obj_id)

func register() -> void:
	if not tab:
		tab = get_default_tab()
	
	if id.is_empty():
		id = resource_path.get_basename().get_file()
	
	if tab:
		if !tab.name.is_empty():
			id = tab.name + ":" + id
	
	if _references.has(id):
		id += "_"
	
	_references[id] = self
	_reference_list.append(self)
	
	SD_Console.i().write_info("object registered: %s" % id)

func unregister() -> void:
	_references.erase(id)
	_reference_list.erase(self)
	
	SD_Console.i().write_warning("object unregistered: %s" % id)
