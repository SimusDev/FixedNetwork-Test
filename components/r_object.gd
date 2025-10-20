extends Resource
class_name R_Object

static var _references: Dictionary[String, R_Object] = {}
static var _reference_list: Array[R_Object] = []

@export var id: String
@export var tab: R_ObjectTab
@export var viewmodel: R_ViewModel

func register() -> void:
	if not viewmodel:
		viewmodel = R_ViewModel.get_placeholder()
	
	if not tab:
		tab = R_ObjectTab.get_default()
	
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
